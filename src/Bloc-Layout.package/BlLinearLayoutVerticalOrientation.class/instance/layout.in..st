layout
layout: anElement in: aRectangle
	|top right bottom left majorBounds elementInnerBounds|
	"Layout subnodes vertically in column one by one
	based on previously measured extent"
	
	top := anElement insets top.
	left := anElement insets left. 
	right := left.
	bottom := top.
	
	anElement managedChildrenDo: [ :child | 
		right := right max: child measuredWidth + (child outsets width max: 0).
		bottom := bottom + child measuredHeight + (child outsets height max: 0) ].
	
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
			self layout horizontalAlignment ifNotNull: [ 
				| x allowedBounds |
				allowedBounds := origin extent: (right - left) @ child measuredHeight.
				x := self layout horizontalAlignment horizontalTranslationFor: childBounds in: allowedBounds.
				childBounds := childBounds translateBy: x@0 ].
			self layout horizontalAlignment ifNull: [ 
				| x allowedBounds |
				allowedBounds := origin extent: elementInnerBounds width @ child measuredHeight.
				x := child constraints horizontal alignment horizontalTranslationFor: childBounds in: allowedBounds.
				childBounds := childBounds translateBy: x@0 ].
			"telling each subnode what bounds to use for layouting process.
			Because measuring process does not modify actual extent
			we need to use a measured one"
			child applyLayoutIn: childBounds.
			"translating origin vertically down for next subnode"
			origin x @(origin y + child measuredHeight + (child outsets height max: 0)) ]