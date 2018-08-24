Class {
	#name : #BlTouchDownEvent,
	#superclass : #BlTouchEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlTouchDownEvent >> sendTo: anObject [
	anObject touchDownEvent: self
]
