layout
layout: anElement in: aRectangle
	| anElementTopLeft anElementBottomRight |
	
	anElementTopLeft := anElement insets topLeft.
	anElementBottomRight := anElement boundsInLocal corner - anElement insets bottomRight.

	anElement managedChildren
		select: [ :aChild | aChild visibility shouldLayout ]
		thenDo: [ :aChild |
			| aMinTopLeft aChildBounds aChildOrigin aChildCorner aChildPosition |
			aMinTopLeft := anElementTopLeft + aChild outsets topLeft.
			
			aChildBounds := aChild measuredBounds.
			aChildOrigin := aChildBounds origin max: aMinTopLeft.
			aChildCorner := aChildBounds corner min: anElementBottomRight - aChild outsets bottomRight.
			aChildPosition := (aChildCorner - aChildBounds extent) max: aMinTopLeft.		
			
			aChild applyLayoutIn: (aChildPosition extent: aChildBounds extent) ]