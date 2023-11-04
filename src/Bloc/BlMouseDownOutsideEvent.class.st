Class {
	#name : 'BlMouseDownOutsideEvent',
	#superclass : 'BlMousePickOutsideEvent',
	#package : 'Bloc',
	#tag : 'Events-Type-Element'
}

{ #category : 'sending' }
BlMouseDownOutsideEvent >> sendTo: anObject [

	anObject mouseDownOutsideEvent: self
]
