measurement
defaultMeasure: anElement with: anExtentSpec
	| aWidth aHeight |
	
	aWidth := self
		calculateSize: anExtentSpec widthSpec
		desired: self paddingLeft + self paddingRight
		min: anElement constraints minWidth.
	
	aHeight := self
		calculateSize: anExtentSpec heightSpec
		desired: self paddingTop + self paddingBottom
		min: anElement constraints minHeight.
	
	anElement measuredExtent: aWidth @ aHeight