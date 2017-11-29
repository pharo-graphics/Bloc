geometry
curvature: aNumber
	"Set an absolute curvature of the arc"

	self
		assert: [ curvatureAnchor isNotNil ]
		description: [ 'Via anchor must exist' ].

	self unregisterAnchor: curvatureAnchor.
	curvatureAnchor := (BlPerpendicularAnchor curvature: aNumber)
		referenceAnchors: { self fromAnchor . self toAnchor }.
	self registerAnchor: curvatureAnchor