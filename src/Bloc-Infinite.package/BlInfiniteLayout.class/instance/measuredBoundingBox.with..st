measurement
measuredBoundingBox: aChildrenBounds with: anExtentSpec
	"Sets the measured extent from the given bounding box of the children and the measurement specs"
	| usedWidth usedHeight aMeasuredWidth aMeasuredHeight |

	usedWidth := aChildrenBounds width + self paddingLeft + self paddingRight.
	usedHeight := aChildrenBounds height + self paddingTop + self paddingBottom.
	
	aMeasuredWidth := self calculateSize: anExtentSpec widthSpec desired: usedWidth min: self minimumWidth.
	aMeasuredHeight := self calculateSize: anExtentSpec heightSpec desired: usedHeight min: self minimumHeight.

	infiniteElement measuredExtent: aMeasuredWidth @ aMeasuredHeight