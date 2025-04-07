"
The mouse move event is fired when a pointing device (usually a mouse) is moved while over an element.

https://developer.mozilla.org/en-US/docs/Web/Events/mousemove

"
Class {
	#name : #BlMouseMoveEvent,
	#superclass : #BlMouseEvent,
	#category : #'Bloc-Events'
}

{ #category : #'instance creation' }
BlMouseMoveEvent class >> button: aMouseButton [
	"Create a sample button move event"

	^ self new
		button: aMouseButton;
		position: 0@0;
		screenPosition: 0@0;
		yourself
]

{ #category : #'instance creation' }
BlMouseMoveEvent class >> middle [
	"Create a mouse move event for testing purposes"

	^ self button: BlMouseButton middle
]

{ #category : #'instance creation' }
BlMouseMoveEvent class >> primary [
	"Create a mouse move event for testing purposes"
	
	^ self button: BlMouseButton primary
]

{ #category : #'instance creation' }
BlMouseMoveEvent class >> secondary [
	"Create a mouse move event for testing purposes"
	
	^ self button: BlMouseButton secondary
]

{ #category : #testing }
BlMouseMoveEvent >> canFindTargetFrom: anElement [

	^ anElement notNil and: [anElement containsGlobalPoint: self position]
]

{ #category : #testing }
BlMouseMoveEvent >> isMouseMove [
	^ true
]

{ #category : #sending }
BlMouseMoveEvent >> sendTo: anObject [
	anObject mouseMoveEvent: self
]
