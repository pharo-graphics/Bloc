instance creation - ticks
minuteTickAt: aMinute
	<gtExample>
	
	^ self minuteTick
		in: [ :aMinuteTick | (aMinute - 1) % 5 = 0 ifTrue: [ aMinuteTick visibility: BlVisibility gone  ] ];
		relocate: ((2 * self radius) - self minuteTickLength - self padding) @ (self radius - (self minuteTickBreadth / 2.0));
		transformDo: [ :aTransform |
			aTransform
				origin: (BlAffineTransformationPositionOrigin position: (self radius negated + self minuteTickLength + self padding) @ (self minuteTickBreadth / 2.0));
				rotateBy: (aMinute - 1) * self minuteRotationDelta ];
		yourself