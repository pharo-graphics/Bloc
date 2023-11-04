Class {
	#name : 'BlHorizontalCoordinateStartAlignment',
	#superclass : 'BlHorizontalCoordinateAlignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'factory' }
BlHorizontalCoordinateStartAlignment >> leftToRight [
	^ BlHorizontalCoordinateLeftAlignment new
		coordinate: coordinate;
		relativeAlignment: relativeAlignment leftToRight
]

{ #category : 'factory' }
BlHorizontalCoordinateStartAlignment >> rightToLeft [
	^ BlHorizontalCoordinateRightAlignment new
		coordinate: coordinate;
		relativeAlignment: relativeAlignment rightToLeft
]
