Class {
	#name : #FensterPhysicalSize,
	#superclass : #FensterSize,
	#category : #'Fenster-Geometry'
}

{ #category : #'api - converting' }
FensterPhysicalSize >> asLogical: aScaleFactor [
	<return: #FensterLogicalSize>
	| aWidth aHeight |
	
	(aScaleFactor <= 0 or: [ aScaleFactor isInfinite ])
		ifTrue: [ (FensterWrongScaleFactor scaleFactor: aScaleFactor) signal ].

	aWidth := self width / aScaleFactor asFloat.
	aHeight := self height / aScaleFactor asFloat.

	^ FensterLogicalSize width: aWidth height: aHeight
]

{ #category : #'api - converting' }
FensterPhysicalSize >> asPhysical: aScaleFactor [
	<return: #FensterPhysicalSize>
	
	^ self
]
