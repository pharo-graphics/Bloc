Class {
	#name : #BlTouchUpEvent,
	#superclass : #BlTouchEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlTouchUpEvent >> sendTo: anObject [
	anObject touchUpEvent: self
]
