layout
fit: anElement with: anExtentSpec
	| boundingBox width height |
		
	boundingBox := self boundingBox: anElement.
	
	width := boundingBox width + anElement padding width.
	height := boundingBox height + anElement padding height.

	anElement measuredExtent: (width @ height)