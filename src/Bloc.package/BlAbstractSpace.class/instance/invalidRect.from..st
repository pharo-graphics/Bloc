change reporting
invalidRect: aDirtyRect from: aNode
	| rect intersectRects|
	rect := (aDirtyRect  expandBy: (1@1)) expanded.
	
	self dirtyAreas detect:[:each| each containsRect: rect] ifFound:[^ self].
	
	intersectRects := self dirtyAreas select: [:each| each intersects: rect] .
	intersectRects ifNotEmpty:[
		self dirtyAreas removeAll: intersectRects.
		intersectRects add:rect.
		rect := intersectRects reduce:[:a :b| a quickMerge:b]].
	self dirtyAreas add: rect.
	
	self hostWindow ifNotNil:[self hostWindow renderNeeded].
	self requestNextPulse