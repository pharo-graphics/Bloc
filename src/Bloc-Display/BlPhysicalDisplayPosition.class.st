Class {
	#name : #BlPhysicalDisplayPosition,
	#superclass : #BlDisplayPosition,
	#category : #'Bloc-Display-Geometry'
}

{ #category : #'api - converting' }
BlPhysicalDisplayPosition >> asLogical: aScaleFactor [

	| aX aY |
	(aScaleFactor <= 0 or: [ aScaleFactor isInfinite ])
		ifTrue: [ (BlWrongScaleFactor scaleFactor: aScaleFactor) signal ].

	aX := self x / aScaleFactor asFloat.
	aY := self y / aScaleFactor asFloat.

	^ BlLogicalDisplayPosition x: aX y: aY
]

{ #category : #'api - converting' }
BlPhysicalDisplayPosition >> asPhysical: aScaleFactor [

	^ self
]
