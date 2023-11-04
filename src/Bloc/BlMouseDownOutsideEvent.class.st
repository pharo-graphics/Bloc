Class {
	#name : #BlMouseDownOutsideEvent,
	#superclass : #BlMousePickOutsideEvent,
	#category : 'Bloc-Events-Type-Element'
}

{ #category : 'sending' }
BlMouseDownOutsideEvent >> sendTo: anObject [

	anObject mouseDownOutsideEvent: self
]
