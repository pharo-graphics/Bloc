accessing
arrowNoseAngle: anAngleInDegrees

	self
		assert: [ anAngleInDegrees > 0 and: [ anAngleInDegrees < 180 ] ]
		description: [ 'Angle should be within interval [0 ... 180]' ].

	arrowNoseAngle := anAngleInDegrees