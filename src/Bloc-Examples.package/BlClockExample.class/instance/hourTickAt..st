instance creation - ticks
hourTickAt: anHour
	<gtExample>
	
	^ self hourTick
		relocate: ((2 * self radius) - self hourTickLength - self padding) @ (self radius - (self hourTickBreadth / 2.0));
		transformDo: [ :aTransform |
			aTransform
				origin: (BlAffineTransformationPositionOrigin position: (self radius negated + self hourTickLength + self padding) @ (self hourTickBreadth / 2.0));
				rotateBy: (anHour - 1) * self hourRotationDelta ];
		yourself