Class {
	#name : #BlMouseOutsideEvent,
	#superclass : #BlSpaceMouseEvent,
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #sending }
BlMouseOutsideEvent >> sendTo: anObject [

	anObject mouseOutsideEvent: self
]
