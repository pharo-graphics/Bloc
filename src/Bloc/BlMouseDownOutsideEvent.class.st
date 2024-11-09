Class {
	#name : #BlMouseDownOutsideEvent,
	#superclass : #BlMousePickOutsideEvent,
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #testing }
BlMouseDownOutsideEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
BlMouseDownOutsideEvent >> sendTo: anObject [

	anObject mouseDownOutsideEvent: self
]
