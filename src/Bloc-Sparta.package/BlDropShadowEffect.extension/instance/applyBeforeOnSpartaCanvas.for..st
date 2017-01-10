*Bloc-Sparta
applyBeforeOnSpartaCanvas: anSpartaCanvas for: anElement
	| aShadowCanvas anEffectBounds |

	anEffectBounds := anElement effectBounds.
	aShadowCanvas := anSpartaCanvas similar: anEffectBounds extent.

	aShadowCanvas transform
		push;
		translateBy: (self offset max: 0@0);
		apply.	

	aShadowCanvas fill
		paint: self color;
		path: (anElement pathCache geomPathOnSpartaCanvas: aShadowCanvas);
		draw.

	anSpartaCanvas filter
		area: anEffectBounds;
		type: (aShadowCanvas gaussianBlurFilter
			stdDeviation: (self width / 2.0 max: 0);
			source: aShadowCanvas);
		draw.

	aShadowCanvas transform pop.
	
	