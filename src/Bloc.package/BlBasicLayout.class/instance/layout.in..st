layout
layout: anElement in: aRectangle

	anElement children accountedByLayout do: [ :child |
		child applyLayoutIn: child measuredBounds asRectangle ]