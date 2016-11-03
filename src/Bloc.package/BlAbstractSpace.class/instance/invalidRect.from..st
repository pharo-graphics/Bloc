change reporting
invalidRect: aDirtyRect from: aNode
	| rect intersectRects|
	rect := (aDirtyRect  expandBy: (1@1)) expanded.
	
	"if rect is already contained in an existing dirty area, do nothing"
	self dirtyAreas detect:[:each| each containsRect: rect] ifFound:[^ self].
	
	"select all areas which intersect rect and replace them by one merged area"
	intersectRects := self dirtyAreas select: [:each| each intersects: rect] .
	intersectRects ifNotEmpty:[
		self dirtyAreas removeAll: intersectRects.
		intersectRects add:rect.
		rect := intersectRects reduce:[:a :b| a quickMerge:b]].
	self dirtyAreas add: rect.
	
	self hostSpace ifNotNil:[self hostSpace renderNeeded].
	self requestNextPulse