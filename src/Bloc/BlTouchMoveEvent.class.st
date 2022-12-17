Class {
	#name : #BlTouchMoveEvent,
	#superclass : #BlTouchEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlTouchMoveEvent >> sendTo: anObject [
	anObject touchMoveEvent: self
]
