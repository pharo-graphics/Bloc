layout
layout: anElement in: aRectangle
	| parentBounds childBounds |
	
	self layoutIgnored: anElement.
	
	"first store parent's local bounds"
	parentBounds := anElement padding inset: (0@0 extent: aRectangle extent).
	"reuse the same instance for children bounds"
	childBounds := BlBounds new.
	
	self
		layeredChildren: anElement
		do: [ :aChild |
			"ask child for its measured bounds"
			childBounds := aChild measuredBounds: childBounds.
			"frame layout supports alignment, so we need to translate child's bounds accordingly to alignment"
			childBounds := self align: aChild bounds: childBounds in: parentBounds.
			"and finally set new bounds"
			aChild applyLayoutIn: childBounds ].