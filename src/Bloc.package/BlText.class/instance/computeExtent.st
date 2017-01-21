geometry extent
computeExtent
| w h|
	self invalidate.
	layoutView := SpMultilineTextLayout new
		rope: textModel rope
		maxWidth: wrappingWidth.
	layoutView measureOn: MozOffscreenCanvas uniqueInstance.
	w := (self wrappingWidth > 0)
		ifTrue: [ self wrappingWidth  ]
		ifFalse: [ layoutView width].
	h := (layoutView height > 0)
		ifTrue: [ layoutView height  ]
		ifFalse: [ self height].
	super extent: w@h.
	"self extent ~= layoutView extent ifTrue: [ layoutView extent: self extent ]."
	self changed