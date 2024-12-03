Class {
	#name : #BlMouseUpEvent,
	#superclass : #BlMousePickEvent,
	#category : #'Bloc-Events'
}

{ #category : #'instance creation' }
BlMouseUpEvent class >> button: aMouseButton [
	"Create a sample button up event for a given button for testing purposes"
	
	^ aMouseButton mouseUpEventClass new
		button: aMouseButton;
		position: 0@0;
		screenPosition: 0@0;
		yourself
]

{ #category : #'instance creation' }
BlMouseUpEvent class >> middle [
	"Create a sample middle button up event for testing purposes"

	^ self button: BlMouseButton middle
]

{ #category : #'instance creation' }
BlMouseUpEvent class >> primary [
	"Create a sample primary button up event for testing purposes"
	
	^ self button: BlMouseButton primary
]

{ #category : #'instance creation' }
BlMouseUpEvent class >> secondary [
	"Create a sample secondary button up event for testing purposes"
	
	^ self button: BlMouseButton secondary
]

{ #category : #converting }
BlMouseUpEvent >> asDoubleClickEvent [
	^ BlDoubleClickEvent new
		copyFrom: self;
		yourself
]

{ #category : #testing }
BlMouseUpEvent >> isMouseUp [
	^ true
]

{ #category : #sending }
BlMouseUpEvent >> sendTo: anObject [
	anObject mouseUpEvent: self
]
