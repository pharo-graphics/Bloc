layout
dispatchLayoutFirstStep
	"The first step of a layout where we
  		- process data source updates
		- decide which animation should run
		- save information about current child elements
		- If necessary, run predictive layout and save its information"

	self state assertLayoutStep: BlInfiniteLayoutStepFlags Start.
	self state isMeasuring: false.
	self eatRequestLayout.
	infoStore clear.
	self onEnterLayoutOrScroll.
	self saveFocusInfo.
	self processDataSourceCommandsAndSetAnimationFlags.
	self state trackOldChangeHolders: (self state willRunSimpleAnimations and: [ itemsChanged ]).
	itemsAddedOrRemoved := false.
	itemsChanged := false.
	self state isPreLayout: self state willRunPredictiveAnimations.
	self state itemCount: self dataSource itemCount.
	layoutPositionsRange := self findMinMaxChildLayoutPositions.
	
	self state willRunSimpleAnimations
		ifTrue: [ self dispatchLayoutFirstStepSimpleAnimations ].
		
	self state willRunPredictiveAnimations
		ifTrue: [ self dispatchLayoutFirstStepPredictiveAnimations ].
	
	self clearOldPositions.
	self onExitLayoutOrScroll.
	self resumeRequestLayout: false.
	self state beStepLayout