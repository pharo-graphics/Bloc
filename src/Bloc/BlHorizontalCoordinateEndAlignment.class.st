Class {
	#name : 'BlHorizontalCoordinateEndAlignment',
	#superclass : 'BlHorizontalCoordinateAlignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'factory' }
BlHorizontalCoordinateEndAlignment >> leftToRight [
	^ BlHorizontalCoordinateRightAlignment new
		coordinate: coordinate;
		relativeAlignment: relativeAlignment leftToRight
]
