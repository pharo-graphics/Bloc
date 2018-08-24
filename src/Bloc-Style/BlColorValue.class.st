Class {
	#name : #BlColorValue,
	#superclass : #BlStyleValue,
	#category : 'Bloc-Style-Value'
}

{ #category : #'as yet unclassified' }
BlColorValue >> defaultAnimation [
	^ BlColorTransition new 
]
