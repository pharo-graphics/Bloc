Extension { #name : #BlGaussianShadowEffect }

{ #category : #'*Bloc-Alexandrie' }
BlGaussianShadowEffect >> aeDrawBelow: aBlElement on: aeCanvas [

	self ensureValidAlphaSurfaceFor: aBlElement on: aeCanvas.

	aeCanvas
		maskSurface: alphaSurface
			x: offset x - self extraShadowSpace
			y: offset y - self extraShadowSpace
			color: color
]

{ #category : #'*Bloc-Alexandrie' }
BlGaussianShadowEffect >> elementHashFor: aBlElement [
	"Answer a hash that is enough to identify when something changed in the element, something that is relevant for this effect."

	^ aBlElement geometry hash bitXor: aBlElement extent hash
]

{ #category : #'*Bloc-Alexandrie' }
BlGaussianShadowEffect >> ensureValidAlphaSurfaceFor: aBlElement on: aeCanvas [

	| visualBounds shadowSpace newElementHash |
	shadowSpace := self extraShadowSpace.
	visualBounds := aBlElement visualBounds.
	newElementHash := self elementHashFor: aBlElement.

	(alphaSurface notNil and: [
		 alphaSurface isNull not and: [
			 alphaSurfaceElementHash = newElementHash ] ]) ifTrue: [ ^ self ].

	alphaSurfaceElementHash := newElementHash.
	alphaSurface :=
		aeCanvas
			newSurfaceWithGaussianShadow: visualBounds extent + (shadowSpace * 2)
			width: width
			canvasDo: [ :alphaCanvas |
				alphaCanvas pathTranslate: shadowSpace asPoint.
				aBlElement aeDrawGeometryOn: alphaCanvas ]
]
