Extension { #name : #BlGradientShadowEffect }

{ #category : #'*Bloc-Alexandrie' }
BlGradientShadowEffect >> aeDrawBelow: aBlElement on: aeCanvas [

	self ensureCreateSahdowSurfaceFor: aBlElement on: aeCanvas.

	aeCanvas
		maskSurface: shadowSurface
		x: offset x - blurRadius
		y: offset y - blurRadius
		color: color
]

{ #category : #'*Bloc-Alexandrie' }
BlGradientShadowEffect >> ensureCreateSahdowSurfaceFor: aBlElement on: aeCanvas [

	| newElementHash extent |
	newElementHash := self elementHashFor: aBlElement.
	(shadowSurface isNil or: [
		 shadowSurface isNull or: [
			 shadowSurfaceElementHash ~= newElementHash ] ]) ifFalse: [ ^ self ].

	shadowSurfaceElementHash := newElementHash.
	extent := aBlElement geometryBounds extent.

	self
		setUpShadowSurfaceFor: aeCanvas
		extent: extent + (blurRadius * 2) ceiling.
	aBlElement geometry
		aeSetUpGradientShadowOn: self
		extent: extent
]

{ #category : #'*Bloc-Alexandrie' }
BlGradientShadowEffect >> setUpCircle: circleRadius [ 

	AeCircleGradientBlurFilter new
		blurRadius: blurRadius color: color;
		center: (circleRadius + blurRadius) asPoint radius: circleRadius;
		drawOn: shadowSurface newContext
]

{ #category : #'*Bloc-Alexandrie' }
BlGradientShadowEffect >> setUpPolygon: aCollection extent: aPoint [ 

	AePolygonGradientBlurFilter new
		blurRadius: blurRadius color: color;
		vertices: aCollection + blurRadius asPoint;
		drawOn: shadowSurface newContext
]

{ #category : #'*Bloc-Alexandrie' }
BlGradientShadowEffect >> setUpRectangleExtent: aPoint [ 

	AeRectangleGradientBlurFilter new
		blurRadius: blurRadius color: color;
		rectangle: (blurRadius asPoint extent: aPoint);
		drawOn: shadowSurface newContext
]

{ #category : #'*Bloc-Alexandrie' }
BlGradientShadowEffect >> setUpRoundedRectangleExtent: aPoint radii: aBlCornerRadii [

	AeRoundedRectangleGradientBlurFilter new
		blurRadius: blurRadius color: color;
		rectangle: (blurRadius asPoint extent: aPoint) radii: {
				aBlCornerRadii topLeft.
				aBlCornerRadii topRight.
				aBlCornerRadii bottomRight.
				aBlCornerRadii bottomLeft };
		drawOn: shadowSurface newContext
]

{ #category : #'*Bloc-Alexandrie' }
BlGradientShadowEffect >> setUpShadowSurfaceFor: aeCanvas extent: aPoint [ 

	| scale |
	scale := aeCanvas deviceScale.
	
	shadowSurface :=
		AeCairoImageSurface
			extent: aPoint * scale
			format: AeCairoSurfaceFormat a8.
	shadowSurface deviceScale: scale.
	
	shadowSurface status ensureIsSuccess
]
