Class {
	#name : 'BlTouchUpEvent',
	#superclass : 'BlTouchEvent',
	#category : 'Bloc-Events'
}

{ #category : 'sending' }
BlTouchUpEvent >> sendTo: anObject [
	anObject touchUpEvent: self
]
