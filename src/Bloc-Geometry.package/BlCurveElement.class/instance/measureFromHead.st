layout
measureFromHead

	self
		assert: [ self hasFromHead ]
		description: [ 'Can not measure an arrowhead if it does not exist' ].

	fromHead measuredBounds position: (self fromPosition - self layoutBounds origin) - (self fromHead margin right @ (self fromHeadBreadth / 2.0)).

	"now we need to rotate the head"
	fromHead transformDo: [ :aTransform |
		| anAngle |
		anAngle := (1@0) angleWith: (self normalizeDirection: self fromDirection) asPoint.
		
		aTransform
			origin: BlAffineTransformationLeftCenterOrigin new;
			translateBy: ((self fromHeadLength - self fromHead margin right) @ 0) negated;
			rotateBy: anAngle radiansToDegrees;
			translateBy: (self fromHead margin right @ 0) ]