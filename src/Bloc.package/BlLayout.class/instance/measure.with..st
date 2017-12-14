measure
measure: anElement with: anExtentSpec
	"Default simple and naive implementation that does not support #fitContent resizing
	strategy of the anElement that uses a layout with this version of measurement"

	anElement measuredExtent: (anExtentSpec sizeFor: anElement extent).
	self measuredChildren: anElement do: [ :aChild |
		self
			measureChild: aChild
			parentSpec: anExtentSpec ]