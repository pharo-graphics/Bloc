Class {
	#name : 'BlLogicalDisplaySize',
	#superclass : 'BlDisplaySize',
	#category : 'Bloc-Display-Geometry',
	#package : 'Bloc-Display',
	#tag : 'Geometry'
}

{ #category : 'api - converting' }
BlLogicalDisplaySize >> asLogical: aScaleFactor [

	^ self
]

{ #category : 'api - converting' }
BlLogicalDisplaySize >> asPhysical: aScaleFactor [

	| aWidth aHeight |
	
	(aScaleFactor <= 0 or: [ aScaleFactor isInfinite ])
		ifTrue: [ (BlWrongScaleFactor scaleFactor: aScaleFactor) signal ].

	aWidth := self width * aScaleFactor.
	aHeight := self height * aScaleFactor.

	^ BlPhysicalDisplaySize width: aWidth height: aHeight
]
