Extension { #name : #TBlDrawingCache }

{ #category : #'*Bloc-Sparta' }
TBlDrawingCache >> drawMeAndChildrenOnSpartaCanvas: aCanvas [
	| aGlobalToLocalMatrix aGlobalToLocalScale aGlobalToLocalScaleMatrix aLocalToGlobalScaleMatrix |
	
	aGlobalToLocalMatrix := BlMatrix2D new matrix: aCanvas transform current.
	aGlobalToLocalScale := aGlobalToLocalMatrix decomposition scale.

	aGlobalToLocalScaleMatrix := (BlMatrix2D new scaleBy: aGlobalToLocalScale).
	aLocalToGlobalScaleMatrix := aGlobalToLocalScaleMatrix inverted.

	(self session ~~ Smalltalk session or: [ self cachedSurface isNil ]) ifTrue: [
		| aCachedCanvas theBounds |
		self session: Smalltalk session.

		theBounds := self invalidationBounds: BlBounds new.
		aGlobalToLocalScaleMatrix transformBounds: theBounds.

		aCachedCanvas := aCanvas similar: theBounds extent ceiling asIntegerPoint.
		aCachedCanvas transform during: [ :aTransform |
			aTransform scaleBy: aGlobalToLocalScale asPoint.
			aTransform apply.
			super drawMeAndChildrenOnSpartaCanvas: aCachedCanvas ].

		self cachedSurface: aCachedCanvas surface.
		aCachedCanvas release ].

	aCanvas transform during: [ :aTransform |
			aTransform multiplyBy: aLocalToGlobalScaleMatrix.
			aTransform apply.
			aCanvas fill
				paint: self cachedSurface;
				path: self cachedSurface bounds;
				draw ]
]
