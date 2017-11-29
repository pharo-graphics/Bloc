geometry
curvatureFraction: aNumber
	"Set a relative fractional curvature of the arc"

	self
		assert: [ curvatureAnchor isNotNil ]
		description: [ 'Via anchor must exist' ].

	self unregisterAnchor: curvatureAnchor.
	curvatureAnchor := (BlPerpendicularFractionAnchor fraction: aNumber)
		referenceAnchors: { self fromAnchor . self toAnchor }.
	self registerAnchor: curvatureAnchor