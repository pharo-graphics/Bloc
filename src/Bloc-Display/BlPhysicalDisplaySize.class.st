Class {
	#name : 'BlPhysicalDisplaySize',
	#superclass : 'BlDisplaySize',
	#category : 'Bloc-Display-Geometry',
	#package : 'Bloc-Display',
	#tag : 'Geometry'
}

{ #category : 'api - converting' }
BlPhysicalDisplaySize >> asLogical: aScaleFactor [
	<return: #BlLogicalDisplaySize>
	| aWidth aHeight |
	
	(aScaleFactor <= 0 or: [ aScaleFactor isInfinite ])
		ifTrue: [ (BlWrongScaleFactor scaleFactor: aScaleFactor) signal ].

	aWidth := self width / aScaleFactor asFloat.
	aHeight := self height / aScaleFactor asFloat.

	^ BlLogicalDisplaySize width: aWidth height: aHeight
]

{ #category : 'api - converting' }
BlPhysicalDisplaySize >> asPhysical: aScaleFactor [
	<return: #BlPhysicalDisplaySize>
	
	^ self
]
