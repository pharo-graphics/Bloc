Class {
	#name : #BlAbstractMorphicHostSpace,
	#superclass : #BlHostSpace,
	#traits : 'TBlSpaceProperties',
	#classTraits : 'TBlSpaceProperties classTrait',
	#instVars : [
		'backBuffer',
		'frontBuffer'
	],
	#category : #'BlocHost-Morphic'
}

{ #category : #initialization }
BlAbstractMorphicHostSpace >> initializeRenderer [

	super initializeRenderer.

	backBuffer := self newExternalForm.
	frontBuffer := self newExternalForm.
	self spaceHostMorph form: frontBuffer
]

{ #category : #rendering }
BlAbstractMorphicHostSpace >> lockSurfaceFor: damagedRectangle scaleFactor: aNumber during: aBlock [

	| currentPhysicalSize temp |
	currentPhysicalSize := self physicalSize asPoint.

	(backBuffer isNil or: [
		backBuffer isNull or: [
			backBuffer extent ~= currentPhysicalSize ] ])
				ifTrue: [ backBuffer := self newExternalForm ].

	(frontBuffer isNil or: [
		frontBuffer isNull or: [
			frontBuffer extent ~= currentPhysicalSize ] ])
				ifTrue: [ frontBuffer := self newExternalForm ].

	renderer
		renderWith: aBlock
		pixels: backBuffer pointer
		stride: backBuffer stride
		physicalRectangle: backBuffer boundingBox
		logicalRectangle: (0 @ 0 extent: self logicalSize asPoint).

	temp := frontBuffer.
	frontBuffer := backBuffer.
	backBuffer := temp.

	self spaceHostMorph form: frontBuffer
]

{ #category : #initialization }
BlAbstractMorphicHostSpace >> newExternalForm [

	| form |
	form := BlExternalForm
		extent: self physicalSize asPoint
		depth: 32.
	form autoRelease.
	form allocateSpace.
	form fillColor: Color transparent.
	^ form
]

{ #category : #'host space - rendering' }
BlAbstractMorphicHostSpace >> requestRedraw [

	self spaceHostMorph ifNotNil: [ :m | m requestRedraw ]
]

{ #category : #accessing }
BlAbstractMorphicHostSpace >> spaceHostMorph [

	^ self subclassResponsibility
]
