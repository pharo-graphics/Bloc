Extension { #name : #BlGaussianShadowEffect }

{ #category : #'*Bloc-Sparta' }
BlGaussianShadowEffect >> applyBeforeOnSpartaCanvas: aSpartaCanvas for: anElement [
	| anEffectExtent anExtraShadowSpace aShadowPath aShadowSurface |

	aShadowPath := anElement geometry pathOnSpartaCanvas: aSpartaCanvas.
	anExtraShadowSpace := self extraShadowSpace.
	
	aShadowSurface := self class cachedSurfaceFor: {
		aShadowPath.
		color.
		offset.
		width
	} ifAbsentPut: [		
		anEffectExtent := anElement effectBounds extent.
		
		aSpartaCanvas similar: anEffectExtent during: [ :aShadowPathCanvas |

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
				aShadowBlurCanvas snapshot ] ] ].	

	aSpartaCanvas fill
		paint: aShadowSurface;
		path: (aShadowSurface bounds translateBy: anExtraShadowSpace asPoint negated + self offset);
		draw
]
