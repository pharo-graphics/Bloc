geometry extent
computeExtent
| w h|
	self invalidate.
	w := (self wrappingWidth > 0)
		ifTrue: [ self wrappingWidth  ]
		ifFalse: [ layoutView width].
	h := layoutView height.
	super extent: w@h.
	"self extent ~= layoutView extent ifTrue: [ layoutView extent: self extent ]."
	self changed