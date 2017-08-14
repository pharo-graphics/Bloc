layout
measuredBounds: aBlBounds
	"Store and return my measured bounds where origin is my current position
	and extent is measured extent in a given mutable BlBounds.
	@see BlElement>>#measuredExtent for more info"
	<return: #BlBounds>

	^ aBlBounds
		origin: self position
		extent: self measuredExtent