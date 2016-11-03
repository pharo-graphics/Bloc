layout
layout: anElement in: aRectangle

	anElement managedChildrenDo: [ :child |
		child applyLayoutIn: child measuredBounds ]