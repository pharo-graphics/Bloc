measure
measureChild: aChildElement of: anElement with: anExtentSpec width: aParentWidth height: aParentHeight
	| childWidthMeasureSpec childHeightMeasureSpec |

	aChildElement constraints horizontal resizer isMatchParent
		ifTrue: [ 
			| weight width |
			weight := (aChildElement constraints frame horizontal weight max: 0).
			width := ((aParentWidth - anElement insets width - aChildElement outsets width) * weight) max: 0.
			childWidthMeasureSpec := BlMeasurementSpec exact: width ]
		ifFalse: [ 
			childWidthMeasureSpec := self
				measurementSpecFor: anExtentSpec widthSpec
				usedSize: anElement insets width + aChildElement outsets width
				resizer: aChildElement constraints horizontal resizer ].

	aChildElement constraints vertical resizer isMatchParent
		ifTrue: [ 
			| weight height |
			weight := (aChildElement constraints frame vertical weight max: 0).
			height := ((aParentHeight - anElement insets height - aChildElement outsets height) * weight) max: 0.
			childHeightMeasureSpec := BlMeasurementSpec exact: height ]
		ifFalse: [ 
			childHeightMeasureSpec := self
				measurementSpecFor: anExtentSpec heightSpec
				usedSize: anElement insets height + aChildElement outsets height
				resizer: aChildElement constraints vertical resizer ].

	aChildElement measure: childWidthMeasureSpec @ childHeightMeasureSpec