Class {
	#name : #BlHostLogicalPosition,
	#superclass : #BlHostPosition,
	#category : #'Bloc-Universe - Host'
}

{ #category : #converting }
BlHostLogicalPosition >> asLogical: aScaleFactor [
	^ self
]

{ #category : #converting }
BlHostLogicalPosition >> asPhysical: aScaleFactor [
	| aX aY |
	
	self
		assert: [ aScaleFactor > 0 and: [ aScaleFactor isInfinite not ] ]
		description: [ 'Scale factor must be a positive non-infinite number' ].

	aX := self x * aScaleFactor.
	aY := self y * aScaleFactor.

	^ BlHostPhysicalPosition x: aX y: aY
]
