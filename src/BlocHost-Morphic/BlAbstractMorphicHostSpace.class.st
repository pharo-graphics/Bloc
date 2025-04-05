Class {
	#name : #BlAbstractMorphicHostSpace,
	#superclass : #BlHostSpace,
	#instVars : [
		'externalForm'
	],
	#category : #'BlocHost-Morphic'
}

{ #category : #initialization }
BlAbstractMorphicHostSpace >> initializeRenderer [

	super initializeRenderer.

	externalForm := BlExternalForm
		extent: self physicalSize asPoint
		depth: 32.
	externalForm autoRelease.
	externalForm allocateSpace.
	externalForm fillColor: Color transparent
]

{ #category : #rendering }
BlAbstractMorphicHostSpace >> lockSurfaceFor: damagedRectangles scaleFactor: aNumber during: aBlock [

	renderer
		renderWith: aBlock
		pixels: externalForm pointer
		stride: externalForm stride
		physicalRectangle: externalForm boundingBox
		logicalRectangle: (0 @ 0 extent: self logicalSize asPoint).

	self spaceHostMorph form: externalForm
]

{ #category : #accessing }
BlAbstractMorphicHostSpace >> spaceHostMorph [

	^ self subclassResponsibility
]
