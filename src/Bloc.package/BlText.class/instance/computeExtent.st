geometry extent
computeExtent
| w h|
	self invalidate.
	layoutView := SpTextLayout
		rope: textModel rope
		properties: { #maxWidth -> wrappingWidth }.
	layoutView initializeOn: (MozCanvas extent: 1@1).
	w := (self wrappingWidth > 0)
		ifTrue: [ self wrappingWidth  ]
		ifFalse: [ layoutView width].
	h := (layoutView height > 0)
		ifTrue: [ layoutView height  ]
		ifFalse: [ self height].
	super extent: w@h.
	"self extent ~= layoutView extent ifTrue: [ layoutView extent: self extent ]."
	self changed