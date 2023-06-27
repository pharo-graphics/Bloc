Class {
	#name : #BlMouseUpOutsideEvent,
	#superclass : #BlMouseOutsideEvent,
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #sending }
BlMouseUpOutsideEvent >> sendTo: anObject [

	anObject mouseUpOutsideEvent: self
]
