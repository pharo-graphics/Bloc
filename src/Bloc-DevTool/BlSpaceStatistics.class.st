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
		'listeners',
		'service',
		'fullGCDuringLastPeriod',
		'incrementalGCDuringLastPeriod',
		'fullGCCount',
		'incrementalGCCount',
		'lastFullGCCount',
		'lastIncrementalGCCount',
		'totalTime'
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

{ #category : #events }
BlSpaceStatistics >> frameEnded: id [

	currentFrames := currentFrames + 1.
	totalFrames := totalFrames + 1.


]

{ #category : #events }
BlSpaceStatistics >> frameStarted: id [

	
]

{ #category : #accessing }
BlSpaceStatistics >> fullFPS [
	
	^ (totalFrames / (self totalTime / 1000)) asFloat
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
	previousMillisecond := 0.
	totalTime := 0.
	currentFrames := 0.
	listeners := OrderedCollection new.
	
	fullGCDuringLastPeriod := 0.
	incrementalGCDuringLastPeriod := 0.
	
	fullGCCount := 0.
	lastFullGCCount := 0.
	
	incrementalGCCount := 0.
	lastIncrementalGCCount := 0.
]

{ #category : #accessing }
BlSpaceStatistics >> phaseStatistics [

	| total |

	total := durationPerPhase sumNumbers.
	
	^ space frame phases collect: [ :e | | duration |
		duration := durationPerPhase at: e ifAbsent: [0].
		{ e. duration milliSeconds. total = 0 ifTrue: [0] ifFalse: [(duration / total) asFloat] } ].
]

{ #category : #events }
BlSpaceStatistics >> recordMilliseconds: millis forFramePhase: phase [

	| value |
	value := durationPerPhase at: phase ifAbsent: [ 0 ].
	durationPerPhase at: phase put: (value + millis)
]

{ #category : #'API - listeners' }
BlSpaceStatistics >> registerListener: aPRSpaceStatisticsWindow [ 
	
	listeners add: aPRSpaceStatisticsWindow 
]

{ #category : #accessing }
BlSpaceStatistics >> space: aBlSpace [

	space := aBlSpace 
]

{ #category : #events }
BlSpaceStatistics >> spaceClosed [

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
BlSpaceStatistics >> totalTime [

	^ totalTime
]

{ #category : #private }
BlSpaceStatistics >> updateValues [

	| currentIncrementalGCCount currentMillisecond currentFullGCCount |
	currentMillisecond := Time millisecondClockValue.

	totalTime := totalTime + (currentMillisecond - previousMillisecond).

	fps := (currentFrames
	        / (currentMillisecond - previousMillisecond / 1000)) asFloat.
	previousMillisecond := Time millisecondClockValue.
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
