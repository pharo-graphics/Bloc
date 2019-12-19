"
The coordinate is measured from the left side of the outer bounds
"
Class {
	#name : #BlHorizontalCoordinateLeftAlignment,
	#superclass : #BlHorizontalCoordinateAlignment,
	#category : #'Bloc-Layouts-Support'
}

{ #category : #translation }
BlHorizontalCoordinateLeftAlignment >> translationOf: aBounds in: aContainerBounds [
	| aRelativeDelta anExpectedLeft |
	
	anExpectedLeft := aContainerBounds left + (aContainerBounds width * coordinate).
	aRelativeDelta := (relativeAlignment translationOf: (0@0 extent: 0@0) in: (0@0 extent: aBounds extent)) x.
	^ (anExpectedLeft - aBounds left - aRelativeDelta) @ 0
]
