private - invalidation
invalidateItemDecorations
	"Invalidate all ItemDecorations.
	If I have item decorations, a layout update will be requested"

	itemDecorations
		ifEmpty: [ ^ self ].
		
	self assertNotInLayoutOrScroll.
	self markItemDecorInsetsDirty.
	self requestLayout