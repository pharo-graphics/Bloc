layout
layout: anElement in: aRectangle

	self normalize: anElement in: aRectangle.

	self layoutIgnored: anElement.
	self
		layeredChildren: anElement
		do: [ :aChild | aChild applyLayoutIn: aChild measuredBounds asRectangle ]