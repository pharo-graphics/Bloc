accessing
geometry: aBlGeometry
	"Attach a geometry which path I should cache"

	self
		assert: [ aBlGeometry isNotNil ]
		description: [ 'Geometry must not be nil' ].

	geometry := aBlGeometry