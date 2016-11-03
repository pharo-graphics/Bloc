measure
measureChild: anElement parentSpec: anExtentSpec widthResizer: widthResizer heightResizer: heightResizer
	| childWidthSpec childHeightSpec |

	childWidthSpec := self layout
		measurementSpecFor: anExtentSpec widthSpec
		usedSize: (self totalMarginOf: anElement isHorizontal: true)
		resizer: widthResizer.

	childHeightSpec := self layout
		measurementSpecFor: anExtentSpec heightSpec
		usedSize: (self totalMarginOf: anElement isHorizontal: false)
		resizer: heightResizer.
		
	anElement measure: (childWidthSpec @ childHeightSpec)