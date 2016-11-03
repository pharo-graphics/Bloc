geometry extent
computeExtent
	| w h|
	[layoutView layout extendOneLineDown] whileTrue.
	layoutView layout updateExtent.
	self invalidate.
	w := (self wrappingWidth > 0)
		ifTrue: [ self wrappingWidth  ]
		ifFalse: [ layoutView layout extent x].
	h := layoutView layout extent y.
	super extent: w@h.
	self extent ~= layoutView extent ifTrue: [ layoutView extent: self extent ].
	self changed