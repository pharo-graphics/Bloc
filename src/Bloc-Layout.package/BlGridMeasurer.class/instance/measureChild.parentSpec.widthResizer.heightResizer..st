measure
measureChild: anElement parentSpec: anExtentSpec widthResizer: widthResizer heightResizer: heightResizer
	| childWidthSpec childHeightSpec |

	childWidthSpec := self layout
		measurementSpecFor: anExtentSpec widthSpec
		usedSize: (self totalMarginOf: anElement isHorizontal: true)
		resizer: (widthResizer ifMatchParent: [ BlLayoutResizer exact: 0 ]).

	childHeightSpec := self layout
		measurementSpecFor: anExtentSpec heightSpec
		usedSize: (self totalMarginOf: anElement isHorizontal: false)
		resizer: (heightResizer ifMatchParent: [ BlLayoutResizer exact: 0 ]).
		
	anElement measure: (childWidthSpec @ childHeightSpec)