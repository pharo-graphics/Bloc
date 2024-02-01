Class {
	#name : #BlHorizontalCoordinateEndAlignment,
	#superclass : #BlHorizontalCoordinateAlignment,
	#category : 'Bloc-Layouts-Alignment'
}

{ #category : #'class initialization' }
BlHorizontalCoordinateEndAlignment class >> initialize [

	self initializeSingletons
]

{ #category : #factory }
BlHorizontalCoordinateEndAlignment >> leftToRight [
	^ BlHorizontalCoordinateRightAlignment new
		coordinate: coordinate;
		relativeAlignment: relativeAlignment leftToRight
]
