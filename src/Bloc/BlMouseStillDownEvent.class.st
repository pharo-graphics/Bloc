Class {
	#name : #BlMouseStillDownEvent,
	#superclass : #BlMouseEvent,
	#category : 'Bloc-Event'
}

{ #category : #testing }
BlMouseStillDownEvent >> isMouseDown [
	^ true
]

{ #category : #sending }
BlMouseStillDownEvent >> sendTo: anObject [
	anObject mouseStillDownEvent: self
]
