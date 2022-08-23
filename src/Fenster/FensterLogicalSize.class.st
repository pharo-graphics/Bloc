Class {
	#name : #FensterLogicalSize,
	#superclass : #FensterSize,
	#category : #'Fenster-Geometry'
}

{ #category : #'api - converting' }
FensterLogicalSize >> asLogical: aScaleFactor [
	^ self
]

{ #category : #'api - converting' }
FensterLogicalSize >> asPhysical: aScaleFactor [
	<return: #FensterPhysicalSize>
	| aWidth aHeight |
	
	(aScaleFactor <= 0 or: [ aScaleFactor isInfinite ])
		ifTrue: [ (FensterWrongScaleFactor scaleFactor: aScaleFactor) signal ].

	aWidth := self width * aScaleFactor.
	aHeight := self height * aScaleFactor.

	^ FensterPhysicalSize width: aWidth height: aHeight
]
