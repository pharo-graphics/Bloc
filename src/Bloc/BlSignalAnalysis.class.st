"
BlSignalAnalysis provides summary information and various views into a log of the main Bloc signals, i.e.:

- ${class:name=BlPulseStatSignal}
- ${class:name=CurrentProcessSignal}

!!Live Signal Analysis

To start an in-memory logger (before the event to be analysed occurs :-)):

[[[
BlSignalAnalysis startDefaultSampling.
]]]

If the expected number of events is large the circular buffer size can be increased, e.g.:

[[[
CircularMemoryLogger entryCount: 15000.
]]]

Once the event that is of interest has occurred:

[[[
BlSignalAnalysis stopAndInspect.
]]]


!!Saving Logging to Disk

If the system is remote, or the UI is locking up as part of the issue, it is also possible to save information to disk for later analysis:

[[[
BlSignalAnalysis startDefaultSampling.
CircularMemoryLogger startAutoSaving.
]]]

Will save a snapshot of the logger each minute.  The log file can then be inspected with (substituting the appropriate file name):

[[[
BlSignalAnalysis gtInspectFile: 'CircularMemoryLogger.stgz'
]]]

 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables

	logger:		<SignalLogger>
	pairs:		<Array>
	slow:		<Array>
	unfinished:		<Array>
	triggerDuration:	<Duration>

"
Class {
	#name : #BlSignalAnalysis,
	#superclass : #Object,
	#instVars : [
		'logger',
		'pairs',
		'unfinished',
		'slow',
		'triggerDuration'
	],
	#category : #'Bloc-Space-Support'
}

{ #category : #'instance creation' }
BlSignalAnalysis class >> gtInspectCircularMemory [
	"Open an inspector on an instance of the receiver analysing the default CircularMemoryLogger"

	^GtInspector openOn: (self logger: CircularMemoryLogger instance)
]

{ #category : #'instance creation' }
BlSignalAnalysis class >> gtInspectFile: aFileReference [

	^GtInspector openOn: 
		(self logger: 
			(MemoryLogger fromStonFile: aFileReference))
]

{ #category : #'instance creation' }
BlSignalAnalysis class >> gtInspectLogger: aSignalLogger [

	^GtInspector openOn: (self logger: aSignalLogger)
]

{ #category : #convenience }
BlSignalAnalysis class >> inspectFileContents: aFileReference [
	"Convenience method for debugging the logger itself - 
	inspect the contents of the supplied file, which is assumed to be a GZip encoded text file"

	GtInspector openOn: (aFileReference asFileReference binaryReadStreamDo: [ :bstream |
		(ZnCharacterReadStream 
			on: (GZipReadStream on: bstream)
			encoding: 'utf8') upToEnd ])
]

{ #category : #accessing }
BlSignalAnalysis class >> logger: aSignalLogger [

	^self new logger: aSignalLogger
]

{ #category : #sampling }
BlSignalAnalysis class >> startDefaultSampling [
	"Convenience method to start recording a useful set of metrics"

	CircularMemoryLogger startBlocGlobalLogger.
	CurrentProcessSignal startSampling.
]

{ #category : #sampling }
BlSignalAnalysis class >> stopAndInspect [
	"Convenience method to stop the collection and inspect the results"

	CurrentProcessSignal stopSampling.
	CircularMemoryLogger instance stop.
	self gtInspectLogger: CircularMemoryLogger instance.
]

{ #category : #accessing }
BlSignalAnalysis >> cpuConsumption [
	"Answer the elapsed time of the paired signals, the consumed time and percentage by time"

	| sortedPairs totalTime consumedTime percentage |

	sortedPairs := self pairs sorted: [ :a :b | a key timestamp < b key timestamp ].
	totalTime := sortedPairs last value timestamp - sortedPairs first key timestamp.
	consumedTime := 0 seconds.
	sortedPairs do: [ :each |
		consumedTime := consumedTime + (each value timestamp - each key timestamp) ].
	percentage := (consumedTime / totalTime) asFloat.
	^{ totalTime. consumedTime. percentage. }
]

{ #category : #acccessing }
BlSignalAnalysis >> forcedDelayCount [

	^self pulseStatRecordings inject: 0 into: 
		[ :s :v | s + v lowPriorityDelayCount ]
]

{ #category : #acccessing }
BlSignalAnalysis >> forcedDelayPercent [
	"Answer the maximum percentage time lost due to forced delays.
	The actual time lost will be something less since there was some work done during this time.
	Currently assumes an 8ms delay."

	| forcedDelayTime signalTimes elapsedTime |

	forcedDelayTime := self forcedDelayCount * 8.
	signalTimes := self pulseStatRecordings collect: [ :each | each timestamp ].
	elapsedTime := (signalTimes last - signalTimes first) asMilliSeconds.
	^(100.0 * forcedDelayTime / elapsedTime) rounded
]

{ #category : #acccessing }
BlSignalAnalysis >> getBlocMainLoopSignals [
	"Answer the Bloc Main Loop signals"

	^self getCurrentProcessSignals select: [ :each | each preemptedName = 'Bloc Main Loop'
		or: [ each nextReadyName = 'Bloc Main Loop' ] ]

]

{ #category : #private }
BlSignalAnalysis >> getCurrentProcessSignals [
	"Answer the current process signals"

	^self recordings select: [ :each | each class = CurrentProcessSignal ]

]

{ #category : #private }
BlSignalAnalysis >> getPairs [
	"Iterate over the records and pair the entries"

	| cache |

	cache := Dictionary new.

	pairs := Array streamContents: [ :stream |
		"Check the consistency of the record.
		-  Can't have two starts in a row
		-  end time should be after start time"
		self taskRecordings do: [ :each |
			(#(start startValue startWithArg) includes: each action) ifTrue: [ 
				self assert: (cache includesKey: each target) not.
				cache at: each target put: each -> nil ]
			ifFalse: [ "#end" | association |
				self assert: (#(end doneValue doneWithArg) includes: each action).
				"Ignore stray #ends, if this was a circular memory logger the #start may be missing"
				association := cache removeKey: each target ifAbsent: [].
				association ifNotNil: [ 
					self assert: each timestamp >= association key timestamp.
					association value: each.
					stream nextPut: association ] ] ] ].

	"Anything left over are unfinished"
	unfinished := cache values collect: [ :each | each key ].
	^pairs

]

{ #category : #private }
BlSignalAnalysis >> getSlow [

	"Collect tasks that took longer than triggerDuration"
	^(self pairs 
		select: [ :each | (each value timestamp - each key timestamp) > triggerDuration ]
		thenCollect: [ :each | { 
			(each value timestamp - each key timestamp).
			each key.
			each value.} ])
				sorted: [ :a :b | a first < b first ]
]

{ #category : #private }
BlSignalAnalysis >> getSlowPulses [
	"Select and order the pulse entries by min time (longest first)"

	| signals |

	signals := (self recordings select: [ :each | each class = BlPulseStatSignal ])
		sorted: [ :a :b | a min < b min ].
	^signals first: (30 min: signals size)
]

{ #category : #inspecting }
BlSignalAnalysis >> gtCurrentProcessFor: aView [
	"Display Tasks that take longer than triggerDuration"
	<gtView>
	^ aView columnedList
		title: 'Current Process' translated;
		priority: 40;
		items: [ self getCurrentProcessSignals ];
		column: 'Signal' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each asString ]; 
				matchParent ]
]

{ #category : #inspecting }
BlSignalAnalysis >> gtRecordingsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Recordings' translated;
		priority: 50;
		items: [ self recordings reverse ];
		column: 'Timestamp' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each timestamp asString ]; 
				matchParent ];
		column: 'Process' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each processId asString ]; 
				matchParent ];
		column: 'Type' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each name ]; 
				matchParent ];
		column: 'Contents' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | String streamContents: [ :s | each printOneLineContentsOn: s ] ]; 
				matchParent ]
]

{ #category : #inspecting }
BlSignalAnalysis >> gtSlowFor: aView [
	"Display Tasks that take longer than triggerDuration"
	<gtView>
	^ aView columnedList
		title: 'Slow Tasks' translated;
		priority: 40;
		items: [ self slow ];
		column: 'Duration' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each first asString ]; 
				matchParent ];
		column: 'Target' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each second target asString ]; 
				matchParent ]
]

{ #category : #inspecting }
BlSignalAnalysis >> gtSlowPulsesFor: aView [
	"Display Tasks that take longer than triggerDuration"
	<gtView>
	^ aView columnedList
		title: 'Pulses' translated;
		priority: 40;
		items: [ self getSlowPulses ];
		column: 'Signal' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each asString ]; 
				matchParent ]
]

{ #category : #inspecting }
BlSignalAnalysis >> gtSummaryFor: aView [
	"Display the summary text"
	<gtView>
	^ aView textEditor
		title: 'Summary' translated;
		priority: 1;
		text: [ self summaryText ]
]

{ #category : #inspecting }
BlSignalAnalysis >> gtUnfinishedFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Unfinished' translated;
		priority: 45;
		items: [ self unfinished reverse ];
		column: 'Timestamp' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each timestamp asString ]; 
				matchParent ];
		column: 'Process' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each processId asString ]; 
				matchParent ];
		column: 'Type' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each name ]; 
				matchParent ];
		column: 'Contents' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | String streamContents: [ :s | each printOneLineContentsOn: s ] ]; 
				matchParent ]
]

{ #category : #initialization }
BlSignalAnalysis >> initialize [ 

	super initialize.
	triggerDuration := 16 milliSeconds.
]

{ #category : #accessing }
BlSignalAnalysis >> l2EntryCount [
	"Sum the number of times that the Bloc pulse loop wait 2ms or less"

	| recordings |

	recordings := self pulseStatRecordings.
	^recordings inject: 0
					into: [ :n :v | n + v l2 ]
]

{ #category : #accessing }
BlSignalAnalysis >> logger: aLogger [

	logger := aLogger.

]

{ #category : #accessing }
BlSignalAnalysis >> maxPulseWaitTime [
	"Answer the maximum time waited."

	| recordings |

	recordings := self pulseStatRecordings.
	^recordings inject: recordings first max
					into: [ :n :v | n max: v max ]
]

{ #category : #accessing }
BlSignalAnalysis >> minPulseWaitTime [
	"Answer the minimum time waited."

	| recordings |

	recordings := self pulseStatRecordings.
	^recordings inject: recordings first min
					into: [ :n :v | n min: v min ]
]

{ #category : #accessing }
BlSignalAnalysis >> pairs [

	^pairs ifNil: [ pairs := self getPairs ]
]

{ #category : #accessing }
BlSignalAnalysis >> processBag [
	"Answer a bag representing each time a process was sampled by CurrentProcessSignal.
	Signals where the preempted and nextReady processes are the same are only counted once."

	| processBag |

	processBag := Bag new.
	self getCurrentProcessSignals do: [ :each |
		processBag add: each preemptedName.
		each preemptedName ~= each nextReadyName ifTrue: 
			[ processBag add: each nextReadyName ] ].
	^processBag
]

{ #category : #accessing }
BlSignalAnalysis >> pulseStatRecordings [
	"Answer the BlPulseStatSignal entries"

	^self recordings select: [ :each | each class = BlPulseStatSignal ]
]

{ #category : #accessing }
BlSignalAnalysis >> recordings [

	^logger recordings
]

{ #category : #accessing }
BlSignalAnalysis >> slow [

	^slow ifNil: [ slow := self getSlow ]
]

{ #category : #private }
BlSignalAnalysis >> summaryOn: aStream [

	"Basic info."
	aStream 
		<< 'Log start time: ';
		print: self recordings first timestamp; cr;
		<< 'Log end time: ';
		print: self recordings last timestamp; cr;
		<< 'Number of entries: ';
		print: self recordings size; cr;
		cr; cr.

	"Pulse summary"
	aStream 
		<< 'Number of pulse entries: ';
		print: self pulseStatRecordings size;
		<< ' (';
		print: self pulseStatRecordings size * BlPulseStatSignal sampleCount;
		<< ' pulse loops)'; cr;
		<< 'Min wait time: ';
		print: self minPulseWaitTime; cr;
		<< 'Max wait time: ';
		print: self maxPulseWaitTime; cr;
		<< 'L2 sum: ';
		print: self l2EntryCount; cr;
		<< 'Forced delays: ';
		print: self forcedDelayCount;
		<< ' (';
		print: self forcedDelayPercent;
		<< '%)'; cr;
		cr; cr.

	"Task Summary"
	aStream 
		<< 'Number of slow tasks: ';
		print: self slow size; cr;
		<< 'Number of unfinished tasks: ';
		print: self unfinished size; cr;
		cr; cr.

	"Process Summary"
	self top5ProcessesOn: aStream.
	aStream cr; cr.
]

{ #category : #accessing }
BlSignalAnalysis >> summaryText [

	^(String streamContents: [ :stream | self summaryOn: stream ]) asRopedText
]

{ #category : #accessing }
BlSignalAnalysis >> taskRecordings [
	"Answer the recordings that represent Tasks with start and stop entries"

	^self recordings select: [ :each | self taskSignals includes: each class ]
]

{ #category : #accessing }
BlSignalAnalysis >> taskSignals [
	"Answer the signals that log tasks start and stop"

	^BlSpaceRenderSignal, BlTaskExecutionSignal, BlTaskItSignal 
]

{ #category : #private }
BlSignalAnalysis >> top5ProcessesOn: aStream [
	"Print the top 5 sample processes on aStream"

	| processCount top5 |

	processCount := self processBag sortedCounts.
	top5 := processCount first: (processCount size min: 5).
	aStream << 'Top 5 processes:'; cr.
	top5 do: [ :each |
		aStream
			<< '- ';
			print: each value;
			<< ': ';
			print: each key;
			cr ].
]

{ #category : #accessing }
BlSignalAnalysis >> unfinished [
	"Answer the Task signals that are unfinished, i.e. have a start log entry, but no corresponding end entry"

	^unfinished ifNil: [ self pairs. unfinished ]
]
