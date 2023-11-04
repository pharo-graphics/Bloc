Class {
	#name : #BlDoubleClickEvent,
	#superclass : #BlMouseEvent,
	#category : #'Bloc-Events'
}

{ #category : #testing }
BlDoubleClickEvent >> isDoubleClick [
	^ true
]

{ #category : #sending }
BlDoubleClickEvent >> sendTo: anObject [
	anObject doubleClickEvent: self
]
