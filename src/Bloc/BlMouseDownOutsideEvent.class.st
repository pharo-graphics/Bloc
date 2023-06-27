Class {
	#name : #BlMouseDownOutsideEvent,
	#superclass : #BlMouseOutsideEvent,
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #sending }
BlMouseDownOutsideEvent >> sendTo: anObject [

	anObject mouseDownOutsideEvent: self
]
