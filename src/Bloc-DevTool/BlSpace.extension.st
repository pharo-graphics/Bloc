Extension { #name : #BlSpace }

{ #category : #'*Bloc-DevTool' }
BlSpace >> addHalosListener [

	self root addEventFilter: BlDevHalosEventListener new
]

{ #category : #'*Bloc-DevTool' }
BlSpace >> enableStatistics [

	| spaceStatistics |
	
	self spaceStatistics ifNotNil: [ ^ self ].
	
	spaceStatistics := BlSpaceStatistics new
		space: self;
		yourself.

	frame := BlProfilingSpaceFrame new
		         fillFrom: frame;
				   spaceStatistics: spaceStatistics;
		         yourself.
		
	self addEventHandlerOn: BlSpaceShownEvent do: [ spaceStatistics spaceShown ]. 
	self addEventHandlerOn: BlSpaceClosedEvent do: [ spaceStatistics spaceClosed ]. 
	self isOpened ifTrue: [ spaceStatistics spaceShown ].
	
	self userData at: #spaceStatistics put: spaceStatistics
]

{ #category : #'*Bloc-DevTool' }
BlSpace >> showStatisticsWindow [
	
	(BlSpaceStatisticsWindow for: self) open 
]

{ #category : #'*Bloc-DevTool' }
BlSpace >> showStatisticsWindowAndKeptOpen [
	
	(BlSpaceStatisticsWindow for: self) 
		keepOpened;
		open 
]

{ #category : #'*Bloc-DevTool' }
BlSpace >> spaceStatistics [

	^ self userData at: #spaceStatistics ifAbsent: [ nil ].
]
