mouse move
handleMouseMove: aMouseMoveEvent
	| aTargetElement isDragStarted |
	"picking and mouse move"

	isDragStarted := self isDragging
		ifFalse: [ dndInProgress := (self canStartDrag: aMouseMoveEvent) ]
		ifTrue: [ true ].

	aTargetElement := self processPicking: aMouseMoveEvent.
	aMouseMoveEvent target: aTargetElement.

	self isDragging
		ifFalse: [ self processMouseMove: aMouseMoveEvent ]
		ifTrue: [ isDragStarted
			ifTrue: [ self processDragStart: aMouseMoveEvent ]
			ifFalse: [ self processDragMove: aMouseMoveEvent ] ]