Class {
	#name : #BlMouseUpOutsideEvent,
	#superclass : #BlMousePickOutsideEvent,
	#category : 'Bloc-Events-Type-Element'
}

{ #category : 'sending' }
BlMouseUpOutsideEvent >> sendTo: anObject [

	anObject mouseUpOutsideEvent: self
]
