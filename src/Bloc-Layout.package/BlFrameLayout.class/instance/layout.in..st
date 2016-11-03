layout
layout: anElement in: aRectangle
	| parentBounds |
	"first store parent's local bounds"
	parentBounds := (0@0) extent: aRectangle extent.

	anElement managedChildren
		select: [ :child | child visibility shouldLayout ]
		thenDo: [ :child |
			| childBounds |
			"ask child for its measured bounds"
			childBounds := child measuredBounds.
			"frame layout supports alignment, so we need to translate child's bounds accordingly to alignment"
			childBounds := self align: child bounds: childBounds in: parentBounds.
			"and finally set new bounds"
			child applyLayoutIn: childBounds ]