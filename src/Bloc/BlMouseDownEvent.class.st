Class {
	#name : #BlMouseDownEvent,
	#superclass : #BlMousePickEvent,
	#category : 'Bloc-Events'
}

{ #category : #'instance creation' }
BlMouseDownEvent class >> button: aMouseButton [
	"Create a sample button down event for a given button for testing purposes"
	<return: #BlMouseDownEvent>

	^ aMouseButton mouseDownEventClass new
		button: aMouseButton;
		position: 0@0;
		screenPosition: 0@0;
		timestamp: DateAndTime now
]

{ #category : #'instance creation' }
BlMouseDownEvent class >> middle [
	"Create a sample middle button down event for testing purposes"
	<return: #BlMouseDownEvent>

	^ self button: BlMouseButton middle
]

{ #category : #'instance creation' }
BlMouseDownEvent class >> primary [
	"Create a sample primary button down event for testing purposes"
	<return: #BlMouseDownEvent>
	
	^ self button: BlMouseButton primary
]

{ #category : #'instance creation' }
BlMouseDownEvent class >> secondary [
	"Create a sample secondary button down event for testing purposes"
	<return: #BlMouseDownEvent>
	
	^ self button: BlMouseButton secondary
]

{ #category : #converting }
BlMouseDownEvent >> asMouseOutsideEvent [

	^ BlMouseDownOutsideEvent new originalEvent: self; canBePropagated: false; yourself
]

{ #category : #testing }
BlMouseDownEvent >> isMouseDown [
	^ true
]

{ #category : #sending }
BlMouseDownEvent >> sendTo: anObject [
	anObject mouseDownEvent: self
]
