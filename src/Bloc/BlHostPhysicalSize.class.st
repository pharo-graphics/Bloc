Class {
	#name : #BlHostPhysicalSize,
	#superclass : #BlHostSize,
	#category : #'Bloc-Universe - Host'
}

{ #category : #converting }
BlHostPhysicalSize >> asLogical: aDpiFactor [
	| aWidth aHeight |
	
	self
		assert: [ aDpiFactor > 0 and: [ aDpiFactor isInfinite not ] ]
		description: [ 'Dpi factor must be a positive non-infinite number' ].

	aWidth := self width / aDpiFactor asFloat.
	aHeight := self height / aDpiFactor asFloat.

	^ BlHostPhysicalSize width: aWidth height: aHeight
]
