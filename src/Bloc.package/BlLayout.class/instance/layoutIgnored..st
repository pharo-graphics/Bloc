layout
layoutIgnored: anElement
	"Layout children ignored by layout so that their measured bounds
	become actual bounds in parent"
	| parentBounds |

	"when layering ignored childed we don't take parent padding into account"
	parentBounds := (0@0 extent: anElement extent).
	"reuse the same instance for children bounds"
	
	anElement children
		select: [ :aChild | aChild constraints ignoredByLayout ]
		thenDo: [ :aChild |
			| childBounds |
			"ask child for its measured bounds"
			childBounds := aChild measuredBounds bounds.
			"frame layout supports alignment, so we need to translate child's bounds accordingly to alignment"
			childBounds := self
				align: aChild
				bounds: (aChild margin expand: childBounds)
				in: parentBounds
				with: aChild constraints ignored alignment.
			"and finally set new bounds"
			aChild applyLayoutIn: (aChild margin inset: childBounds) ]