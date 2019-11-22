Extension { #name : #TBlDrawingCache }

{ #category : #'*Bloc-Sparta' }
TBlDrawingCache >> drawMeWithEffectsOnCanvas: aCanvas [
	| aGlobalToLocalScale |

	self withAllParentsDo: [ :eachElement |
		(self class isDrawingCacheEnabledFor: eachElement)
			ifFalse: [ ^ super drawMeWithEffectsOnCanvas: aCanvas ] ].

	self damageReported: false.

	aGlobalToLocalScale := aCanvas transform current scale.

	(self session ~~ Smalltalk session or: [ self cachedSurface isNil ]) ifTrue: [
		| theBounds aCachedSurface |
		
		theBounds := self invalidationBounds: BlBounds new.
		theBounds scaleBy: aGlobalToLocalScale.

		aCachedSurface := aCanvas similar: theBounds extent ceiling asIntegerPoint during: [ :aCachedCanvas |
				aCachedCanvas transform
					by: [ :aTransform | aTransform scaleBy: aGlobalToLocalScale asPoint ]
					during: [ super drawMeWithEffectsOnCanvas: aCachedCanvas ].
			aCachedCanvas snapshot ].

		self session: Smalltalk session.
		self cachedSurface: aCachedSurface ].

	aCanvas transform
		by: [ :aTransform | aTransform scaleBy: 1.0 / aGlobalToLocalScale ]
		during: [
			aCanvas fill
				paint: self cachedSurface;
				path: self cachedSurface bounds;
				antialiasNone;
				draw ]
]
