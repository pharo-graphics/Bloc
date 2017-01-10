accessing
boundsInParent
	^ (self owner localBoundsToParent: (SpartaRectangle fromRectangle: self boundsInLocal)) asRectangle