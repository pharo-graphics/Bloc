Class {
	#name : #BlMouseProcessingTest,
	#superclass : #BlAbstractEventProcessingTest,
	#category : #'Bloc-Tests-Universe'
}

{ #category : #accessing }
BlMouseProcessingTest >> firedEvents [

	^ space mouseProcessor firedEvents
]

{ #category : #tests }
BlMouseProcessingTest >> testClickCreation [

	self sendInsideTargetEvent: BlMouseDownEvent primary.
	self
		assertFiredEventIs: BlMouseDownEvent
		target: self childA
		withPropagation: true.

	self sendInsideTargetEvent: BlMouseUpEvent primary.
	self
		assertFiredEventIs: BlMouseUpEvent
		target: self childA
		withPropagation: true.
	self
		assertFiredEventIs: BlClickEvent
		target: self childA
		withPropagation: true.

	self childA transform
		scaleBy: 2 @ 2;
		apply.
	self sendEvent: (BlMouseDownEvent primary position: 100 @ 100).
	self
		assertFiredEventIs: BlMouseDownEvent
		target: self childA
		withPropagation: true
]

{ #category : #tests }
BlMouseProcessingTest >> testDblClickCreation [

	self sendInsideTargetEvent: BlMouseDownEvent primary.
	self
		assertFiredEventIs: BlMouseDownEvent
		target: self childA
		withPropagation: true.

	self sendInsideTargetEvent: BlMouseUpEvent primary.
	self
		assertFiredEventIs: BlMouseUpEvent
		target: self childA
		withPropagation: true.
	self
		assertFiredEventIs: BlClickEvent
		target: self childA
		withPropagation: true.

	self sendInsideTargetEvent: BlMouseDownEvent primary.
	self
		assertFiredEventIs: BlMouseDownEvent
		target: self childA
		withPropagation: true.

	self sendInsideTargetEvent: BlMouseUpEvent primary.
	self
		assertFiredEventIs: BlMouseUpEvent
		target: self childA
		withPropagation: true.
	self
		assertFiredEventIs: BlDoubleClickEvent
		target: self childA
		withPropagation: true
]

{ #category : #tests }
BlMouseProcessingTest >> testDragCreation [
	"make child draggable"

	self childA
		addEventHandlerOn: BlDragStartEvent
		do: [ :anEvent | anEvent consume ].

	self sendInsideTargetEvent: BlMouseDownEvent primary.
	self
		assertFiredEventIs: BlMouseDownEvent
		target: self childA
		withPropagation: true.

	self sendInsideTargetEvent: BlMouseMoveEvent primary.
	self
		assertFiredEventIs: BlMouseOverEvent
		target: self childA
		withPropagation: true.
	self
		assertFiredEventIs: BlMouseEnterEvent
		target: self childA
		withPropagation: false.
	self
		assertFiredEventIs: BlMouseEnterEvent
		target: self root
		withPropagation: false.
	self
		assertFiredEventIs: BlMouseMoveEvent
		target: self childA
		withPropagation: true.

	self sendInsideTargetEvent: BlMouseMoveEvent primary.
	self
		assertFiredEventIs: BlMouseMoveEvent
		target: self childA
		withPropagation: true.

	self sendOutsideTargetEvent: BlMouseMoveEvent primary.
	self
		assertFiredEventIs: BlDragStartEvent
		target: self childA
		withPropagation: true.
	self
		assertFiredEventIs: BlDragEvent
		target: self childA
		withPropagation: true.
	self
		assertFiredEventIs: BlDragLeaveEvent
		target: self childA
		withPropagation: false.

	self sendOutsideTargetEvent: BlMouseUpEvent primary.

	self
		assertFiredEventIs: BlDropEvent
		target: self space root
		withPropagation: true.
	self
		assertFiredEventIs: BlDragEndEvent 
		target: self childA
		withPropagation: true
]

{ #category : #tests }
BlMouseProcessingTest >> testEnterExitCreation [

	self sendOutsideTargetEvent: BlMouseMoveEvent new.
	self
		assertFiredEventIs: BlMouseOverEvent
		target: self root
		withPropagation: true.
	self
		assertFiredEventIs: BlMouseEnterEvent
		target: self root
		withPropagation: false.
	self
		assertFiredEventIs: BlMouseMoveEvent
		target: self root
		withPropagation: true.

	self sendInsideTargetEvent: BlMouseMoveEvent new.
	self
		assertFiredEventIs: BlMouseOutEvent
		target: self root
		withPropagation: true.
	self
		assertFiredEventIs: BlMouseOverEvent
		target: self childA
		withPropagation: true.
	self
		assertFiredEventIs: BlMouseEnterEvent
		target: self childA
		withPropagation: false.
	self
		assertFiredEventIs: BlMouseMoveEvent
		target: self childA
		withPropagation: true.

	self sendOutsideTargetEvent: BlMouseMoveEvent new.
	self
		assertFiredEventIs: BlMouseOutEvent
		target: self childA
		withPropagation: true.
	self
		assertFiredEventIs: BlMouseLeaveEvent
		target: self childA
		withPropagation: false.
	self
		assertFiredEventIs: BlMouseOverEvent
		target: self root
		withPropagation: true.
	self
		assertFiredEventIs: BlMouseMoveEvent
		target: self root
		withPropagation: true
]

{ #category : #tests }
BlMouseProcessingTest >> testMouseMove [

	self sendInsideTargetEvent: BlMouseMoveEvent primary.
	self
		assertFiredEventIs: BlMouseOverEvent
		target: self childA
		withPropagation: true.
	self
		assertFiredEventIs: BlMouseEnterEvent
		target: self childA
		withPropagation: false.
	self
		assertFiredEventIs: BlMouseEnterEvent
		target: self root
		withPropagation: false.
	self
		assertFiredEventIs: BlMouseMoveEvent
		target: self childA
		withPropagation: true.

	self sendOutsideTargetEvent: BlMouseMoveEvent primary.
	self
		assertFiredEventIs: BlMouseOutEvent
		target: self childA
		withPropagation: true.
	self
		assertFiredEventIs: BlMouseLeaveEvent
		target: self childA
		withPropagation: false.
	self
		assertFiredEventIs: BlMouseOverEvent
		target: self root
		withPropagation: true.
	self
		assertFiredEventIs: BlMouseMoveEvent
		target: self root
		withPropagation: true
]

{ #category : #tests }
BlMouseProcessingTest >> testNotDraggable [

	self sendInsideTargetEvent: BlMouseDownEvent primary.
	self
		assertFiredEventIs: BlMouseDownEvent
		target: self childA
		withPropagation: true.

	self sendInsideTargetEvent: BlMouseMoveEvent primary.
	self
		assertFiredEventIs: BlMouseOverEvent
		target: self childA
		withPropagation: true.
	self
		assertFiredEventIs: BlMouseEnterEvent
		target: self childA
		withPropagation: false.
	self
		assertFiredEventIs: BlMouseEnterEvent
		target: self root
		withPropagation: false.
	self
		assertFiredEventIs: BlMouseMoveEvent
		target: self childA
		withPropagation: true.

	self sendOutsideTargetEvent: BlMouseMoveEvent primary.
	self
		assertFiredEventIs: BlDragStartEvent
		target: self childA
		withPropagation: true.

	self
		assertFiredEventIs: BlMouseOutEvent
		target: self childA
		withPropagation: true.
	self
		assertFiredEventIs: BlMouseLeaveEvent
		target: self childA
		withPropagation: false.
	self
		assertFiredEventIs: BlMouseOverEvent
		target: self root
		withPropagation: true.
	self
		assertFiredEventIs: BlMouseMoveEvent
		target: self root
		withPropagation: true.

	self sendOutsideTargetEvent: BlMouseUpEvent primary.
	self
		assertFiredEventIs: BlMouseUpEvent
		target: self root
		withPropagation: true
]
