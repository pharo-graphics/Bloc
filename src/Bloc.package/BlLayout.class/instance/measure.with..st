measure
measure: anElement with: anExtentSpec
	"Default simple and naive implementation that does not support content wrapping"

	anElement measuredExtent: (anExtentSpec sizeFor: anElement extent).
	anElement managedChildrenDo: [ :each |
		self
			measureChild: each
			parentSpec: anExtentSpec
			widthUsed: 0
			heightUsed: 0 ]