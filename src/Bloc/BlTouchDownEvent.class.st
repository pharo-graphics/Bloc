Class {
	#name : #BlTouchDownEvent,
	#superclass : #BlTouchEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlTouchDownEvent >> sendTo: anObject [
	anObject touchDownEvent: self
]
