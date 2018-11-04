Extension { #name : #BlDropShadowEffect }

{ #category : #'*Bloc-Sparta' }
BlDropShadowEffect >> applyBeforeOnSpartaCanvas: aSpartaCanvas for: anElement [
	| aShadowCanvas anEffectBounds |

	anEffectBounds := anElement effectBounds.
	
	aShadowCanvas := aSpartaCanvas similar: anEffectBounds extent.
	aShadowCanvas transform
		by: [ :t | t translateBy: (self offset max: 0@0) ]
		during: [
			aShadowCanvas fill
				paint: self color;
				path: (anElement geometry pathOnSpartaCanvas: aShadowCanvas);
				draw.

			aSpartaCanvas filter
				area: anEffectBounds;
				type: (aShadowCanvas gaussianBlurFilter
					stdDeviation: (self width / 2.0 max: 0);
					source: aShadowCanvas);
				draw ].
]
