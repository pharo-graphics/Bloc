Class {
	#name : #BlHostLogicalSize,
	#superclass : #BlHostSize,
	#category : #'Bloc-Universe - Host'
}

{ #category : #converting }
BlHostLogicalSize >> asPhysical: aDpiFactor [
	| aWidth aHeight |
	
	self
		assert: [ aDpiFactor > 0 and: [ aDpiFactor isInfinite not ] ]
		description: [ 'Dpi factor must be a positive non-infinite number' ].

	aWidth := self width * aDpiFactor.
	aHeight := self height * aDpiFactor.

	^ BlHostPhysicalSize width: aWidth height: aHeight
]
