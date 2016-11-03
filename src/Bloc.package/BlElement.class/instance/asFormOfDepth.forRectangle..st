converting
asFormOfDepth: depth forRectangle: rect
	| s fc |
	s := AthensCairoSurface extent: rect extent asIntegerPoint.
	s
		drawDuring: [ :c | 
			c pathTransform translateBy: rect origin negated.
			self dirty: true.
			self invalidate.
			self forceLayout.
			self fullDrawOnAthensCanvas: c ].
	fc := FormCanvas extent: rect extent.
	s displayOnMorphicCanvas: fc at: 0 @ 0.
	^ fc form