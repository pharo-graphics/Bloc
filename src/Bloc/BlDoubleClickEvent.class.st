Class {
	#name : 'BlDoubleClickEvent',
	#superclass : 'BlMouseEvent',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'testing' }
BlDoubleClickEvent >> isDoubleClick [
	^ true
]

{ #category : 'sending' }
BlDoubleClickEvent >> sendTo: anObject [
	anObject doubleClickEvent: self
]
