event processing entrypoint
processMouseMove: anEvent
	"picking and mouse move"
	dndInProgress := currentDragTarget isNotNil or:[
		(self canBeDragEvent:anEvent) and:[ anEvent primaryButtonPressed]].
	lastMouseEvent := anEvent.
	self preProcess: anEvent.
	"check drag"
	self subprocessDragEvent:anEvent.
	"exit/enter/over/out/dragenter/dragleave events management + focus"
	self subprocessEnterExitEvent: anEvent.
	"dragstart/drag events management"
	self subprocessDragEnterExitEvent: anEvent.
	
	"update last overed target"
	lastOverTarget := anEvent target.
	
	"store last entered targets"	
	lastEnteredTargets := currentEnteredTargets.
	
	self postProcess: anEvent