layout
layout: anElement in: aRectangle
	| parentBounds |
	
	self layoutIgnored: anElement.
	
	"first store parent's local bounds"
	parentBounds := anElement padding inset: (0@0 extent: aRectangle extent).

	self
		layeredChildren: anElement
		do: [ :aChild |
			| childBounds |
			"ask child for its measured bounds"
			childBounds := BlBounds fromRectangle: (anElement margin expand: aChild measuredBounds bounds).
			"frame layout supports alignment, so we need to translate child's bounds accordingly to alignment"
			childBounds := childBounds := self
				align: aChild
				bounds: childBounds
				in: parentBounds
				with: aChild constraints frame alignment.
			"and finally set new bounds"
			aChild applyLayoutIn: childBounds ].