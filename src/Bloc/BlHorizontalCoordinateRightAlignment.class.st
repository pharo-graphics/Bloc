"
The coordinate is measured from the right side of the outer bounds

"
Class {
	#name : #BlHorizontalCoordinateRightAlignment,
	#superclass : #BlHorizontalCoordinateAlignment,
	#category : #'Bloc-Layouts-Alignment'
}

{ #category : #translation }
BlHorizontalCoordinateRightAlignment >> translationOf: aBounds in: aContainerBounds [
	| aRelativeDelta anExpectedRight |
		
	anExpectedRight := (aContainerBounds width * coordinate).
	aRelativeDelta := (relativeAlignment translationOf: (0@0 extent: 0@0) in: (0@0 extent: aBounds extent)) x.
	^ (aContainerBounds width - aBounds width - anExpectedRight + aBounds right - aRelativeDelta) @ 0.
]
