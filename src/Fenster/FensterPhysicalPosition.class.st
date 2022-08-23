Class {
	#name : #FensterPhysicalPosition,
	#superclass : #FensterPosition,
	#category : #'Fenster-Geometry'
}

{ #category : #'api - converting' }
FensterPhysicalPosition >> asLogical: aScaleFactor [
	| aX aY |
	
	(aScaleFactor <= 0 or: [ aScaleFactor isInfinite ])
		ifTrue: [ (FensterWrongScaleFactor scaleFactor: aScaleFactor) signal ].

	aX := self x / aScaleFactor asFloat.
	aY := self y / aScaleFactor asFloat.

	^ FensterLogicalPosition x: aX y: aY
]

{ #category : #'api - converting' }
FensterPhysicalPosition >> asPhysical: aScaleFactor [
	^ self
]
