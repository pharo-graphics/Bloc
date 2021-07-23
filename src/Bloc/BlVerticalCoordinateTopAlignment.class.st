Class {
	#name : 'BlVerticalCoordinateTopAlignment',
	#superclass : 'BlVerticalCoordinateAlignment',
	#category : 'Bloc-Layouts-Alignment'
}

{ #category : 'translation' }
BlVerticalCoordinateTopAlignment >> translationOf: aBounds in: aContainerBounds [
	| aRelativeDelta anExpectedTop |
	
	anExpectedTop := aContainerBounds top + (aContainerBounds height * coordinate).
	aRelativeDelta := (relativeAlignment translationOf: (0@0 extent: 0@0) in: (0@0 extent: aBounds extent)) y.
	^ 0 @ (anExpectedTop - aBounds top - aRelativeDelta)
]
