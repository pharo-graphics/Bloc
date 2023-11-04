Class {
	#name : #BlLogicalDisplayPosition,
	#superclass : #BlDisplayPosition,
	#category : #'Bloc-Display-Geometry'
}

{ #category : #'api - converting' }
BlLogicalDisplayPosition >> asLogical: aScaleFactor [

	^ self
]

{ #category : #'api - converting' }
BlLogicalDisplayPosition >> asPhysical: aScaleFactor [

	| aX aY |
	
	(aScaleFactor <= 0 or: [ aScaleFactor isInfinite ])
		ifTrue: [ (BlWrongScaleFactor scaleFactor: aScaleFactor) signal ].

	aX := self x * aScaleFactor.
	aY := self y * aScaleFactor.

	^ BlPhysicalDisplayPosition x: aX y: aY
]
