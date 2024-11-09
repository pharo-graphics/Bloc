Class {
	#name : #BlMouseUpOutsideEvent,
	#superclass : #BlMousePickOutsideEvent,
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #testing }
BlMouseUpOutsideEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
BlMouseUpOutsideEvent >> sendTo: anObject [

	anObject mouseUpOutsideEvent: self
]
