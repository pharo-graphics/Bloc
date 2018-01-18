mouse drag
processDragMove: aMouseMoveEvent

	"check drag"
	self fireAsDragEvent: aMouseMoveEvent.

	"dragstart/drag events management"
	currentDragTarget ifNotNil: [ self subprocessDragEnterExitEvent: aMouseMoveEvent ].
	
	"update last overed target"
	lastOverTarget := aMouseMoveEvent target.
	
	"store last entered targets"
	lastEnteredTargets := currentEnteredTargets