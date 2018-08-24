Class {
	#name : #BlDoubleClickEvent,
	#superclass : #BlMouseEvent,
	#category : 'Bloc-Event'
}

{ #category : #testing }
BlDoubleClickEvent >> isDoubleClick [
	^ true
]

{ #category : #sending }
BlDoubleClickEvent >> sendTo: anObject [
	anObject dblClickEvent: self
]
