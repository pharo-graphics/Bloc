Extension { #name : #BlGaussianShadowEffect }

{ #category : #'*Bloc-Sparta' }
BlGaussianShadowEffect >> applyBeforeOnSpartaCanvas: aSpartaCanvas for: anElement [
	| anExtraShadowSpace aShadowSurface |

	anExtraShadowSpace := self extraShadowSpace.
	
	aShadowSurface := self
		aquireShadowSurfaceOnSpartaCanvas: aSpartaCanvas
		for: anElement
		padding: anExtraShadowSpace.

	aSpartaCanvas fill
		paint: aShadowSurface;
		path: (aShadowSurface bounds translateBy: anExtraShadowSpace asPoint negated + self offset);
		antialiasNone;
		draw
]

{ #category : #'*Bloc-Sparta' }
BlGaussianShadowEffect >> aquireShadowSurfaceOnSpartaCanvas: aSpartaCanvas for: anElement padding: anExtraShadowSpace [
	<return: #TSpartaSurface>
	| aShadowPath aShadowSurface |

	aShadowPath := anElement geometry pathOnSpartaCanvas: aSpartaCanvas.
	
	aShadowSurface := self class cachedSurfaceFor: {
		aShadowPath.
		color.
		offset.
		width
	} ifAbsentPut: [
		self
			renderShadowPath: aShadowPath
			onSpartaCanvas: aSpartaCanvas
			for: anElement
			padding: anExtraShadowSpace ].

	^ aShadowSurface
]

{ #category : #'*Bloc-Sparta' }
BlGaussianShadowEffect >> renderShadowPath: aShadowPath onSpartaCanvas: aSpartaCanvas for: anElement padding: anExtraShadowSpace [
	<return: #TSpartaSurface>
	| anEffectExtent |

	anEffectExtent := anElement effectBounds extent.

	^ aSpartaCanvas similar: anEffectExtent during: [ :aShadowPathCanvas |

		aShadowPathCanvas transform
			by: [ :t | t translateBy: anExtraShadowSpace ]
			during: [ aShadowPathCanvas fill
					paint: self color;
					path: aShadowPath;
					draw ].

		aSpartaCanvas similar: anEffectExtent during: [ :aShadowBlurCanvas |
			aShadowBlurCanvas filter
				area: aShadowPathCanvas bounds;
				type:
					(aShadowPathCanvas filters blur
						stdDeviation: (self width max: 0);
						source: aShadowPathCanvas);
				draw.
			aShadowBlurCanvas snapshot ] ]
]
