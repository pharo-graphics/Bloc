accessing
scaleStrategy: aBlScalableStrategy
	"Set scale strategy used to compute scaling factor of the content element.
	Note: I request layout update"
	
	scaleStrategy := aBlScalableStrategy.
	self requestLayout