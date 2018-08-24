Extension { #name : #BlDropShadowEffect }

{ #category : #'*Bloc-Sparta' }
BlDropShadowEffect >> applyBeforeOnSpartaCanvas: aSpartaCanvas for: anElement [
	| aShadowCanvas anEffectBounds |

	anEffectBounds := anElement effectBounds.
	aShadowCanvas := aSpartaCanvas similar: anEffectBounds extent.

	aShadowCanvas transform
		push;
		translateBy: (self offset max: 0@0);
		apply.	

	aShadowCanvas fill
		paint: self color;
		path: (anElement geometry pathOnSpartaCanvas: aShadowCanvas);
		draw.

	aSpartaCanvas filter
		area: anEffectBounds;
		type: (aShadowCanvas gaussianBlurFilter
			stdDeviation: (self width / 2.0 max: 0);
			source: aShadowCanvas);
		draw.

	aShadowCanvas transform pop.
	
	
]
