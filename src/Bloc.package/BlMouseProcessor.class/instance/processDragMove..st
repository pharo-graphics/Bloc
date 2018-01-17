mouse move
processDragMove: aMouseMoveEvent

	"check drag"
	self fireAsDragEvent: aMouseMoveEvent.

	"exit/enter/over/out/dragenter/dragleave events management + focus"
	self subprocessEnterExitEvent: aMouseMoveEvent.

	"dragstart/drag events management"
	currentDragTarget ifNotNil: [ self subprocessDragEnterExitEvent: aMouseMoveEvent ].
	
	"update last overed target"
	lastOverTarget := aMouseMoveEvent target.
	
	"store last entered targets"
	lastEnteredTargets := currentEnteredTargets