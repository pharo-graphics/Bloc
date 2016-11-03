layout
layout: anElement in: aRectangle
	|top right bottom left majorBounds elementInnerBounds|
	"Layout subnodes vertically in column one by one
	based on previousely measured extent"
	
	top := anElement insets top.
	left := anElement insets left. 
	right := left.
	bottom := top.
	
	anElement managedChildrenDo: [ :child |
		right := right + child measuredWidth + (child outsets width max: 0).
		bottom := bottom max: child measuredHeight + (child outsets height max: 0) ].
	
	majorBounds := (left@top corner: right@bottom).
	elementInnerBounds := anElement innerBounds.
	majorBounds = elementInnerBounds ifFalse: [
		|x y|
		x := self layout horizontalAlignment horizontalTranslationFor: majorBounds in: elementInnerBounds.
		y := self layout verticalAlignment verticalTranslationFor: majorBounds in: elementInnerBounds.
		majorBounds := majorBounds translateBy: x@y ].

	right := majorBounds right.
	bottom := majorBounds bottom.
	left := majorBounds left.
	top := majorBounds top.
	
	anElement managedChildren
		inject: left @ top
		into: [ :origin :child |
			| childBounds |
			childBounds := origin + (child outsets topLeft max: 0@0) extent: child measuredExtent.
			self layout verticalAlignment ifNotNull: [ 
				| y allowedBounds |
				allowedBounds := origin extent: child measuredWidth @ (bottom - top).
				y := self layout verticalAlignment verticalTranslationFor: childBounds in: allowedBounds.
				childBounds := childBounds translateBy: 0@y ].
			self layout verticalAlignment ifNull: [ 
				| y allowedBounds |
				allowedBounds := origin extent: child measuredWidth @ elementInnerBounds height.
				y := child constraints vertical alignment verticalTranslationFor: childBounds in: allowedBounds.
				childBounds := childBounds translateBy: 0@y ].
			"telling each subnode what bounds to use for layouting process.
			Because measuring process does not modify actual extent
			we need to use a measured one"
			child applyLayoutIn: childBounds.
			"translating origin vertically down for next subnode"
			(origin x + child measuredWidth + (child outsets width max: 0)) @ origin y ]