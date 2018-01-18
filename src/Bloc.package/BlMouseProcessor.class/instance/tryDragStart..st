mouse drag
tryDragStart: aMouseMoveEvent
	"Try to start a drag and return true if drag actually started, otherwise false"
	<return: #Boolean>
	| aDragTarget aDragStartEvent |
	
	aDragTarget := previousMouseDownEvent target.
	
	aDragStartEvent := (aMouseMoveEvent asDragStartEvent
		startButtons: dragStartMask;
		target: aDragTarget;
		gestureSource: aDragTarget;
		yourself).

	aDragStartEvent := self fireEvent: aDragStartEvent.
	
	currentDragTarget := aDragStartEvent isConsumed
		ifTrue: [ aDragTarget ]
		ifFalse: [ nil ].

	^ dndInProgress := aDragStartEvent isConsumed