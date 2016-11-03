layout
measure: anElement with: anExtentSpec
	
	anElement childrenDo: [ :each |
		self
			measureChild: each
			parentSpec: anExtentSpec
			widthUsed: 0
			heightUsed: 0.
		each relocate: each measuredBounds origin.
		each resize: each measuredBounds extent ].

	self applyOn: anElement managedChildren.
	self fit: anElement with: anExtentSpec