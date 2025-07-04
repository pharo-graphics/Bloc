"
I collect the statistics of executing an space.
- FPS
- GCs
- Duration of Phases
"
Class {
	#name : #BlSpaceStatistics,
	#superclass : #Object,
	#instVars : [
		'space',
		'totalFrames',
		'durationPerPhase',
		'currentFrames',
		'previousMillisecond',
		'fps',
		'fpsSamples',
		'listeners',
		'service',
		'fullGCDuringLastPeriod',
		'incrementalGCDuringLastPeriod',
		'fullGCCount',
		'incrementalGCCount',
		'lastFullGCCount',
		'lastIncrementalGCCount',
		'hasClosed',
		'totalMilliseconds'
	],
	#category : #'Bloc-DevTool-Profiling'
}

{ #category : #events }
BlSpaceStatistics >> doUpdate [

	self updateValues.
	listeners do: [ :e | e refresh ]
]

{ #category : #accessing }
BlSpaceStatistics >> fps [

	^ fps 
]

{ #category : #accessing }
BlSpaceStatistics >> fpsSamples [

	^ fpsSamples 
]

{ #category : #events }
BlSpaceStatistics >> frameEnded: id [

	currentFrames := currentFrames + 1.
	totalFrames := totalFrames + 1.

	listeners do: [ :e | e frameEnded ].
]

{ #category : #events }
BlSpaceStatistics >> frameStarted: id [

	
]

{ #category : #accessing }
BlSpaceStatistics >> fullGCCount [

	^ fullGCCount
]

{ #category : #accessing }
BlSpaceStatistics >> fullGCCount: anObject [

	fullGCCount := anObject
]

{ #category : #accessing }
BlSpaceStatistics >> fullGCDuringLastPeriod [
			
	^ fullGCDuringLastPeriod
]

{ #category : #accessing }
BlSpaceStatistics >> incrementalGCCount [

	^ incrementalGCCount
]

{ #category : #accessing }
BlSpaceStatistics >> incrementalGCCount: anObject [

	incrementalGCCount := anObject
]

{ #category : #accessing }
BlSpaceStatistics >> incrementalGCDuringLastPeriod [
			
	^ incrementalGCDuringLastPeriod
]

{ #category : #initialization }
BlSpaceStatistics >> initialize [

	super initialize.
	totalFrames := 0.
	durationPerPhase := Dictionary new.

	fps := 0.
	fpsSamples := OrderedCollection new: 50.
	previousMillisecond := 0.
	totalMilliseconds := 0.
	currentFrames := 0.
	listeners := OrderedCollection new.
	
	fullGCDuringLastPeriod := 0.
	incrementalGCDuringLastPeriod := 0.
	
	fullGCCount := 0.
	lastFullGCCount := 0.
	
	incrementalGCCount := 0.
	lastIncrementalGCCount := 0.
	
	hasClosed := false
]

{ #category : #accessing }
BlSpaceStatistics >> phaseStatistics [

	| total |
	total := durationPerPhase sumNumbers.

	^ space frame phases collect: [ :each |
		| duration |
		duration := durationPerPhase at: each ifAbsent: [ 0 ].
		{	each.
			duration milliSeconds.
			total = 0
				ifTrue: [ 0 ]
				ifFalse: [ (duration / total) asFloat ] } ]
]

{ #category : #events }
BlSpaceStatistics >> recordMilliseconds: millis forFramePhase: phase [

	| value |
	value := durationPerPhase at: phase ifAbsent: [ 0 ].
	durationPerPhase at: phase put: (value + millis)
]

{ #category : #'API - listeners' }
BlSpaceStatistics >> registerListener: aPRSpaceStatisticsListener [
	
	listeners add: aPRSpaceStatisticsListener 
]

{ #category : #accessing }
BlSpaceStatistics >> space [

	^ space
]

{ #category : #accessing }
BlSpaceStatistics >> space: aBlSpace [

	space := aBlSpace 
]

{ #category : #events }
BlSpaceStatistics >> spaceClosed [

	hasClosed ifTrue: [ ^self ].
	hasClosed := true.
	
	service ifNotNil: [service stop].
	
	self updateValues.

	listeners do: [:e | e closed].

]

{ #category : #events }
BlSpaceStatistics >> spaceShown [

	lastFullGCCount := Smalltalk vm fullGCCount.
	lastIncrementalGCCount := Smalltalk vm incrementalGCCount.

	previousMillisecond := Time millisecondClockValue.
	service := TKTParameterizableService new 
		name: 'Update Space Statistics ' , self identityHash printString;
		step: [ self doUpdate ];
		start;
		yourself
]

{ #category : #accessing }
BlSpaceStatistics >> totalFPS [
	
	^ (totalFrames / (self totalMilliseconds / 1000)) asFloat
]

{ #category : #accessing }
BlSpaceStatistics >> totalFrames [
	
	^ totalFrames
]

{ #category : #accessing }
BlSpaceStatistics >> totalMilliseconds [

	^ totalMilliseconds
]

{ #category : #accessing }
BlSpaceStatistics >> totalTime [

	self
		deprecated: 'Use totalMilliseconds'
		transformWith: '`@receiver totalTime' -> '`@receiver totalMilliseconds'.

	^ totalMilliseconds
]

{ #category : #private }
BlSpaceStatistics >> updateValues [

	| currentIncrementalGCCount currentMillisecond currentFullGCCount secondPassed |
	currentMillisecond := Time millisecondClockValue.

	totalMilliseconds := totalMilliseconds + (currentMillisecond - previousMillisecond).

	secondPassed := (currentMillisecond - previousMillisecond) / 1000.

	fps := secondPassed = 0 
		ifTrue: [ 0 ]
		ifFalse: [ (currentFrames / secondPassed) asFloat ].

	fpsSamples add: { currentMillisecond. fps }.
	previousMillisecond := currentMillisecond.
	currentFrames := 0.

	currentFullGCCount := Smalltalk vm fullGCCount.
	fullGCDuringLastPeriod := currentFullGCCount - lastFullGCCount.
	fullGCCount := fullGCCount + fullGCDuringLastPeriod.
	lastFullGCCount := currentFullGCCount.

	currentIncrementalGCCount := Smalltalk vm incrementalGCCount.
	incrementalGCDuringLastPeriod := currentIncrementalGCCount
	                                 - lastIncrementalGCCount.
	incrementalGCCount := incrementalGCCount
	                      + incrementalGCDuringLastPeriod.
	lastIncrementalGCCount := currentIncrementalGCCount
]
