Class {
	#name : 'BlHorizontalCoordinateEndAlignment',
	#superclass : 'BlHorizontalCoordinateAlignment',
	#category : 'Bloc-Layouts-Alignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'factory' }
BlHorizontalCoordinateEndAlignment >> leftToRight [
	^ BlHorizontalCoordinateRightAlignment new
		coordinate: coordinate;
		relativeAlignment: relativeAlignment leftToRight
]
