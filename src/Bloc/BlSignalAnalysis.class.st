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

{ #category : #'as yet unclassified' }
BlSignalAnalysis class >> gtInspectLogger: aSignalLogger [

	^GtInspector openOn: (self logger: aSignalLogger)
]

{ #category : #accessing }
BlSignalAnalysis class >> logger: aSignalLogger [

	^self new logger: aSignalLogger
]

{ #category : #'as yet unclassified' }
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

	cache := IdentityDictionary new.

	pairs := Array streamContents: [ :stream |
		"Check the consistency of the record.
		-  Can't have two starts in a row
		-  end time should be after start time"
		records do: [ :each |
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

	"Collect actions that took longer than triggerDuration"
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
		items: [ records reverse ];
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
BlSignalAnalysis >> logger: aLogger [

	logger := aLogger.
	records := logger recordings select: [ :each | self signals includes: each class ].
	"Inspection convenience: populate all the instance variables"
	self slow.
]

{ #category : #accessing }
BlSignalAnalysis >> pairs [

	^pairs ifNil: [ pairs := self getPairs ]
]

{ #category : #accessing }
BlSignalAnalysis >> signals [
	"Answer the signals included in the analysis"

	^BlSpaceRenderSignal, BlTaskExecutionSignal 
]

{ #category : #accessing }
BlSignalAnalysis >> slow [

	^slow ifNil: [ slow := self getSlow ]
]

{ #category : #printing }
BlSignalAnalysis >> statusOn: stream [

	self tasksOn: stream.
	self rendersOn: stream.
]

{ #category : #accessing }
BlSignalAnalysis >> statusString [

	^String streamContents: [ :stream | self statusOn: stream ]
]

{ #category : #accessing }
BlSignalAnalysis >> unfinished [

	^unfinished ifNil: [ self pairs. unfinished ]
]
