Class {
	#name : #BlEventProcessingTest,
	#superclass : #BlEventTestCase,
	#category : 'Bloc-Tests-Universe'
}

{ #category : #tests }
BlEventProcessingTest >> testClickCreation [
	self sendInsideTargetEvent: (BlMouseDownEvent primary).
	self assertFiredEventIs: BlMouseDownEvent target: self child withPropagation: true.

	self sendInsideTargetEvent: (BlMouseUpEvent primary).
	self assertFiredEventIs: BlMouseUpEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlClickEvent target: self child withPropagation: true.
	
	self child transform
		scaleBy: 2@2;
		apply.
	self sendEvent: (BlMouseDownEvent primary position: 100@100).
	self assertFiredEventIs: BlMouseDownEvent target: self child withPropagation: true
]

{ #category : #tests }
BlEventProcessingTest >> testDblClickCreation [

	self sendInsideTargetEvent: (BlMouseDownEvent primary).
	self assertFiredEventIs:  BlMouseDownEvent target: self child withPropagation: true.
	
	self sendInsideTargetEvent: (BlMouseUpEvent primary).
	self assertFiredEventIs:  BlMouseUpEvent target: self child withPropagation: true.
	self assertFiredEventIs:  BlClickEvent target: self child withPropagation: true.
	
	self sendInsideTargetEvent: (BlMouseDownEvent primary).
	self assertFiredEventIs:  BlMouseDownEvent target: self child withPropagation: true.
	
	self sendInsideTargetEvent: (BlMouseUpEvent primary).
	self assertFiredEventIs:  BlMouseUpEvent target: self child withPropagation: true.
	self assertFiredEventIs:  BlDoubleClickEvent target: self child withPropagation: true.
]

{ #category : #tests }
BlEventProcessingTest >> testDragCreation [
	
	"make child draggable"
	self child addEventHandlerOn: BlDragStartEvent do: [ :anEvent | anEvent consumed: true ].

	self sendInsideTargetEvent: BlMouseDownEvent primary.
	self assertFiredEventIs: BlMouseDownEvent target: self child withPropagation: true.
	
	self sendInsideTargetEvent: BlMouseMoveEvent primary.
	self assertFiredEventIs: BlMouseOverEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlMouseEnterEvent target: self child withPropagation: false.
	self assertFiredEventIs: BlMouseEnterEvent target: self root withPropagation: false.
	self assertFiredEventIs: BlMouseMoveEvent target: self child withPropagation: true.
	
	self sendInsideTargetEvent: BlMouseMoveEvent primary.
	self assertFiredEventIs: BlMouseMoveEvent target: self child withPropagation: true.
	
	self sendOutsideTargetEvent: BlMouseMoveEvent primary.
	self assertFiredEventIs: BlDragStartEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlDragEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlDragLeaveEvent target: self child withPropagation: false.
	self assertFiredEventIs: BlDragOverEvent target: self root withPropagation: true.
	
	self sendOutsideTargetEvent: BlMouseUpEvent primary.

	self assertFiredEventIs: BlDragEndEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlDropEvent target: self root withPropagation: true
]

{ #category : #tests }
BlEventProcessingTest >> testEnterExitCreation [

	self sendOutsideTargetEvent: BlMouseMoveEvent new.
	self assertFiredEventIs: BlMouseOverEvent target: self root withPropagation: true.
	self assertFiredEventIs: BlMouseEnterEvent target: self root withPropagation: false.
	self assertFiredEventIs: BlMouseMoveEvent target: self root withPropagation: true.
	
	self sendInsideTargetEvent: BlMouseMoveEvent new.
	self assertFiredEventIs: BlMouseOutEvent target: self root withPropagation: true.
	self assertFiredEventIs: BlMouseOverEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlMouseEnterEvent target: self child withPropagation: false.
	self assertFiredEventIs: BlMouseMoveEvent target: self child withPropagation: true.
	
	self sendOutsideTargetEvent: BlMouseMoveEvent new.
	self assertFiredEventIs: BlMouseOutEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlMouseLeaveEvent target: self child withPropagation: false.
	self assertFiredEventIs: BlMouseOverEvent target: self root withPropagation: true.
	self assertFiredEventIs: BlMouseMoveEvent target: self root withPropagation: true.
	
]

{ #category : #tests }
BlEventProcessingTest >> testMouseMove [
	
	self sendInsideTargetEvent: BlMouseMoveEvent primary.
	self assertFiredEventIs: BlMouseOverEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlMouseEnterEvent target: self child withPropagation: false.
	self assertFiredEventIs: BlMouseEnterEvent target: self root withPropagation: false.
	self assertFiredEventIs: BlMouseMoveEvent target: self child withPropagation: true.
	
	self sendOutsideTargetEvent: BlMouseMoveEvent primary.
	self assertFiredEventIs: BlMouseOutEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlMouseLeaveEvent target: self child withPropagation: false.
	self assertFiredEventIs: BlMouseOverEvent target: self root withPropagation: true.
	self assertFiredEventIs: BlMouseMoveEvent target: self root withPropagation: true.
]

{ #category : #tests }
BlEventProcessingTest >> testNotDraggable [
	self sendInsideTargetEvent: BlMouseDownEvent primary.
	self assertFiredEventIs: BlMouseDownEvent target: self child withPropagation: true.
	
	self sendInsideTargetEvent: BlMouseMoveEvent primary.
	self assertFiredEventIs: BlMouseOverEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlMouseEnterEvent target: self child withPropagation: false.
	self assertFiredEventIs: BlMouseEnterEvent target: self root withPropagation: false.
	self assertFiredEventIs: BlMouseMoveEvent target: self child withPropagation: true.
	
	self sendOutsideTargetEvent: BlMouseMoveEvent primary.
	self assertFiredEventIs: BlDragStartEvent target: self child withPropagation: true.
	
	self assertFiredEventIs: BlMouseOutEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlMouseLeaveEvent target: self child withPropagation: false.
	self assertFiredEventIs: BlMouseOverEvent target: self root withPropagation: true.
	self assertFiredEventIs: BlMouseMoveEvent target: self root withPropagation: true.
		
	self sendOutsideTargetEvent: BlMouseUpEvent primary.
	self assertFiredEventIs: BlMouseUpEvent target: self root withPropagation: true
]
