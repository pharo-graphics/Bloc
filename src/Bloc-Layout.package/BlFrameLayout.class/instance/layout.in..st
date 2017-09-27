layout
layout: anElement in: aRectangle
	| parentBounds |
	
	self layoutIgnored: anElement.
	
	"first store parent's local bounds"
	parentBounds := anElement padding inset: (0@0 extent: aRectangle extent).
	"reuse the same instance for children bounds"
	
	self
		layeredChildren: anElement
		do: [ :aChild |
			| childBounds |
			"ask child for its measured bounds"
			childBounds := aChild measuredBounds bounds.
			"frame layout supports alignment, so we need to translate child's bounds accordingly to alignment"
			childBounds := self align: aChild bounds: childBounds in: parentBounds.
			"and finally set new bounds"
			aChild applyLayoutIn: childBounds ].