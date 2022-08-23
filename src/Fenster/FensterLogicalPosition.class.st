Class {
	#name : #FensterLogicalPosition,
	#superclass : #FensterPosition,
	#category : #'Fenster-Geometry'
}

{ #category : #'api - converting' }
FensterLogicalPosition >> asLogical: aScaleFactor [
	^ self
]

{ #category : #'api - converting' }
FensterLogicalPosition >> asPhysical: aScaleFactor [
	<return: #FensterPhysicalPosition>
	| aX aY |
	
	(aScaleFactor <= 0 or: [ aScaleFactor isInfinite ])
		ifTrue: [ (FensterWrongScaleFactor scaleFactor: aScaleFactor) signal ].

	aX := self x * aScaleFactor.
	aY := self y * aScaleFactor.

	^ FensterPhysicalPosition x: aX y: aY
]
