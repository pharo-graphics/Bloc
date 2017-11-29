layout
measureToHead

	self
		assert: [ self hasToHead ]
		description: [ 'Can not measure an arrowhead if it does not exist' ].

	toHead measuredBounds position: (self toPosition - self layoutBounds origin) - ((self toHeadLength - self toHead margin right) @ (self toHeadBreadth / 2.0)).

	"now we need to rotate the head"
	toHead transformDo: [ :aTransform |
		| anAngle |

		anAngle := (1@0) angleWith: (self normalizeDirection: self toDirection) asPoint.
		aTransform
			origin: BlAffineTransformationRightCenterOrigin new;
			"we should take static margin into account in order to rotate arounded right center with offset"
			translateBy: (self toHead margin left @ 0) negated;
			rotateBy: anAngle radiansToDegrees;
			translateBy: (self toHead margin left @ 0) ]