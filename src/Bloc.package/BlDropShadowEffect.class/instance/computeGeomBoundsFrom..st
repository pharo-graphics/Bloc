effect
computeGeomBoundsFrom: anInputGeomBounds
	| originX originY cornerX cornerY |
	originX := self width - self offset x max: 0.
	originY := self width - self offset y max: 0.
	cornerX := self width + self offset x max: 0.
	cornerY := self width + self offset y max: 0.
	^ anInputGeomBounds expandBy: (originX @ originY corner: cornerX @ cornerY)