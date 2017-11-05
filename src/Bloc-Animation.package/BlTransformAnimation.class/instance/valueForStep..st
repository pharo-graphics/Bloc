pulse
valueForStep: aDelta
	
	"we should recompute destination matrix every step because transformation origins may have changed"
	toMatrix := transformation invalidateMatrix matrix.
	^ BlElementAbsoluteTransformation matrix: (fromMatrix interpolate: aDelta to: toMatrix)