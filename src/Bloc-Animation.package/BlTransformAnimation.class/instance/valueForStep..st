pulse
valueForStep: aDelta
	^ BlElementAbsoluteTransformation matrix: (fromMatrix interpolate: aDelta to: toMatrix)