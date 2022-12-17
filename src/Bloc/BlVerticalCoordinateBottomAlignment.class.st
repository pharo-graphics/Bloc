Class {
	#name : #BlVerticalCoordinateBottomAlignment,
	#superclass : #BlVerticalCoordinateAlignment,
	#category : #'Bloc-Layouts-Alignment'
}

{ #category : #translation }
BlVerticalCoordinateBottomAlignment >> translationOf: aBounds in: aContainerBounds [
	| aRelativeDelta anExpectedBottom |
		
	anExpectedBottom := aContainerBounds height * coordinate.
	aRelativeDelta := (relativeAlignment translationOf: (0@0 extent: 0@0) in: (0@0 extent: aBounds extent)) y.
	^ 0 @ (aContainerBounds height - aBounds height - anExpectedBottom + aBounds bottom - aRelativeDelta).
]
