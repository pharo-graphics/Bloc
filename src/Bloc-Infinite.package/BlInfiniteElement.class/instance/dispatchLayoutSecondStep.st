layout
dispatchLayoutSecondStep
	"The second layout step where we do the actual layout of the element for the final state.
	This step might be run multiple times if necessary (e.g. measure)."
	
	self eatRequestLayout.
	self onEnterLayoutOrScroll.
	
	self state
		assertLayoutStep: BlInfiniteLayoutStepFlags Layout
		or: BlInfiniteLayoutStepFlags Animations.
	
	dataSourceManager consumeCommandsInOnePass.
	self state itemCount: dataSource itemCount.
	self state deletedInvisibleItemCountSincePreviousLayout: 0.
	
	"Run layout"
	self state isPreLayout: false.
	layout layoutChildren.
	self state structureChanged: false.
	
	"layoutChildren may have caused user code to disable item animations; re-check"
	self state beStepAnimations.
	self onExitLayoutOrScroll.
	self resumeRequestLayout: false