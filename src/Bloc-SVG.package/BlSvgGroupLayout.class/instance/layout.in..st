layout
layout: anElement in: aRectangle
	| visualBounds |
	
	super layout: anElement in: aRectangle.
	
	anElement hasChildren
		ifFalse: [ ^ self ].
	
	visualBounds := (anElement children first localBoundsToParent: (BlBounds fromRectangle: anElement children first visualBounds)).
	anElement children do: [ :child |	visualBounds merge: (child localBoundsToParent: (BlBounds fromRectangle: child visualBounds)) ].

	anElement size: (visualBounds corner max: 0@0)