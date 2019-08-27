Extension { #name : #TBlDrawingCache }

{ #category : #'*Bloc-Sparta' }
TBlDrawingCache >> drawMeWithEffectsOnCanvas: aCanvas [
	| aGlobalToLocalMatrix aGlobalToLocalScale aGlobalToLocalScaleMatrix aLocalToGlobalScaleMatrix |

	self withAllParentsDo: [ :eachElement |
		(self class isDrawingCacheEnabledFor: eachElement)
			ifFalse: [ ^ super drawMeWithEffectsOnCanvas: aCanvas ] ].

	self damageReported: false.

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
		aCachedCanvas transform
			by: [ :aTransform | aTransform scaleBy: aGlobalToLocalScale asPoint ]
			during: [ super drawMeWithEffectsOnCanvas: aCachedCanvas ].

		self cachedSurface: aCachedCanvas surface.
		aCachedCanvas release ].

	aCanvas transform
		by: [ :aTransform | aTransform multiplyBy: aLocalToGlobalScaleMatrix ]
		during: [
			aCanvas fill
				paint: self cachedSurface;
				path: self cachedSurface bounds;
				antialiasNone;
				draw ]
]
