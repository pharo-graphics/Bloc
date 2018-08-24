Class {
	#name : #BlTouchMoveEvent,
	#superclass : #BlTouchEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlTouchMoveEvent >> sendTo: anObject [
	anObject touchMoveEvent: self
]
