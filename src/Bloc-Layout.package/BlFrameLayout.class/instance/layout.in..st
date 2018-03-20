layout
layout: anElement in: aRectangle
	| parentBounds |
	
	self layoutIgnored: anElement.
	
	"first store parent's local bounds"
	parentBounds := anElement padding inset: (0@0 extent: aRectangle extent).

	self
		layeredChildren: anElement
		do: [ :aChild |
			| childBounds alloowedBounds |
			"ask child for its measured bounds"
			childBounds := aChild measuredBounds bounds copy.
			alloowedBounds := aChild margin inset: parentBounds copy.
		
			"frame layout supports alignment, so we need to translate child's bounds accordingly to alignment"
			childBounds := childBounds := self
				align: aChild
				bounds: childBounds
				in: alloowedBounds
				with: aChild constraints frame alignment.
			"and finally set new bounds"
			aChild applyLayoutIn: childBounds ].