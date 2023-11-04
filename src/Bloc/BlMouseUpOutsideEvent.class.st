Class {
	#name : 'BlMouseUpOutsideEvent',
	#superclass : 'BlMousePickOutsideEvent',
	#package : 'Bloc',
	#tag : 'Events-Type-Element'
}

{ #category : 'sending' }
BlMouseUpOutsideEvent >> sendTo: anObject [

	anObject mouseUpOutsideEvent: self
]
