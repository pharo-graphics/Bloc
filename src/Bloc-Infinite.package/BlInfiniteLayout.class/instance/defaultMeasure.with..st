measurement
defaultMeasure: anElement with: anExtentSpec
	| aWidth aHeight |

	aWidth := self
		calculateSize: anExtentSpec widthSpec
		desired: self paddingLeft + self paddingRight
		min: self minimumWidth.
	
	aWidth := aWidth min: self maximumWidth.
	
	aHeight := self
		calculateSize: anExtentSpec heightSpec
		desired: self paddingTop + self paddingBottom
		min: self minimumHeight.
		
	aHeight := aHeight min: self maximumHeight.
	
	anElement measuredExtent: aWidth @ aHeight