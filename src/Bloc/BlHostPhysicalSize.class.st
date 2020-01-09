Class {
	#name : #BlHostPhysicalSize,
	#superclass : #BlHostSize,
	#category : #'Bloc-Universe - Host'
}

{ #category : #converting }
BlHostPhysicalSize >> asLogical: aScaleFactor [
	| aWidth aHeight |
	
	self
		assert: [ aScaleFactor > 0 and: [ aScaleFactor isInfinite not ] ]
		description: [ 'Dpi factor must be a positive non-infinite number' ].

	aWidth := self width / aScaleFactor asFloat.
	aHeight := self height / aScaleFactor asFloat.

	^ BlHostPhysicalSize width: aWidth height: aHeight
]
