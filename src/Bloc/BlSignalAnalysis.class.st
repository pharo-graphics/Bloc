Class {
	#name : #BlSignalAnalysis,
	#superclass : #Object,
	#instVars : [
		'logger',
		'records',
		'pairs',
		'unfinished',
		'slow',
		'triggerDuration'
	],
	#category : #'Bloc-Space-Support'
}

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

{ #category : #accessing }
BlSignalAnalysis class >> logger: aSignalLogger [

	^self new logger: aSignalLogger
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
			each action = #start ifTrue: [ 
				self assert: (cache includesKey: each target) not.
				cache at: each target put: each -> nil ]
			ifFalse: [ "#end" | association |
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
		title: 'Slow' translated;
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
		<< 'L2 entry count: ';
		print: self l2EntryCount; cr;
		cr; cr.


	aStream 
		<< 'Number of slow tasks: ';
		print: self slow size; cr;
		<< 'Number of unfinished tasks: ';
		print: self unfinished size; cr;
		cr; cr.
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

	^BlSpaceRenderSignal, BlTaskExecutionSignal 
]

{ #category : #accessing }
BlSignalAnalysis >> unfinished [
	"Answer the Task signals that are unfinished, i.e. have a start log entry, but no corresponding end entry"

	^unfinished ifNil: [ self pairs. unfinished ]
]
