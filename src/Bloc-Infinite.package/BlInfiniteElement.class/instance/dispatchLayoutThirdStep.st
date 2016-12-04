layout
dispatchLayoutThirdStep
	"The final step of the layout where we save the information about elements for animations,
	trigger animations and do any necessary cleanup."
	
	self state assertLayoutStep: BlInfiniteLayoutStepFlags Animations.
	self eatRequestLayout.
	self onEnterLayoutOrScroll.
	self state beStepStart.
	
	self state willRunSimpleAnimations
		ifTrue: [ self dispatchLayoutThirdStepSimpleAnimations ].
	
	layout removeAndRecycleScrapOn: recycler.
	self state previousLayoutItemCount: self state itemCount.
	dataSourceChangedAfterLayout := false.
	self state runSimpleAnimations: false.
	self state runPredictiveAnimations: false.
	self layout requestedSimpleAnimations: false.
	
	self removeChangedScrap.
	layout layoutCompleted.
	self onExitLayoutOrScroll.
	self resumeRequestLayout: false.
	infoStore clear.
	
	(self didChildPositionsRangeChange: layoutPositionsRange)
		ifTrue: [ self dispatchOnScrolled: 0@0 ].
	self recoverFocusFromState.
	self resetFocusInfo