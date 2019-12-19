Class {
	#name : #BlHorizontalCoordinateEndAlignment,
	#superclass : #BlHorizontalCoordinateAlignment,
	#category : #'Bloc-Layouts-Support'
}

{ #category : #factory }
BlHorizontalCoordinateEndAlignment >> leftToRight [
	^ BlHorizontalCoordinateRightAlignment new
		coordinate: coordinate;
		relativeAlignment: relativeAlignment leftToRight
]
