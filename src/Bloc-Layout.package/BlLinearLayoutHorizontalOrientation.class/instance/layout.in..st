layout
layout: anElement in: aRectangle
	|top right bottom left majorBounds elementInnerBounds|
	"Layout subnodes vertically in column one by one
	based on previousely measured extent"

	top := anElement insets top.
	left := anElement insets left. 
	right := left.
	bottom := top.
	
	self layout direction with: anElement managedChildren do: [ :child |
		right := right + child measuredWidth + (child outsets width max: 0).
		bottom := bottom max: child measuredHeight + (child outsets height max: 0) ].
	
	majorBounds := (left@top corner: right@bottom).
	elementInnerBounds := anElement padding inset: anElement boundsInLocal.
	majorBounds = elementInnerBounds ifFalse: [
		| translation |
		translation := (self layout horizontalAlignment directed: self layout direction) translationOf: majorBounds in: elementInnerBounds.
		majorBounds := majorBounds translateBy: translation ].

	right := majorBounds right.
	bottom := majorBounds bottom.
	left := majorBounds left.
	top := majorBounds top.
	
	self layout direction
		with: anElement managedChildren
		inject: left @ top
		into: [ :origin :child |
			| childBounds childMarginBounds childConstraints |
			childConstraints := child constraints linear.
			childBounds := origin + (child outsets topLeft max: 0@0) extent: child measuredExtent.
			childMarginBounds := origin extent: child measuredExtent + (child outsets extent max: 0@0).  

			self layout verticalAlignment ifNotNull: [ 
				| translation allowedBounds |
				allowedBounds := childMarginBounds origin extent: child measuredWidth @ elementInnerBounds height.
				translation := self layout verticalAlignment translationOf: childMarginBounds in: allowedBounds.
				childBounds := childBounds translateBy: translation ].

			self layout verticalAlignment ifNull: [ 
				| translation allowedBounds |
				allowedBounds := childMarginBounds origin extent: child measuredWidth @ elementInnerBounds height.
				translation := childConstraints vertical alignment translationOf: childMarginBounds in: allowedBounds.
				childBounds := childBounds translateBy: translation ].
			
			"telling each subnode what bounds to use for layouting process.
			Because measuring process does not modify actual extent
			we need to use a measured one"
			child applyLayoutIn: childBounds.
			"translating origin horizontally right for next subnode"
			(origin x + child measuredWidth + (child outsets width max: 0)) @ origin y ]