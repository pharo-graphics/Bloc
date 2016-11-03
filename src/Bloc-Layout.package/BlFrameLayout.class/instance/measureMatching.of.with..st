measure
measureMatching: children of: anElement with: anExtentSpec
		
	children size <= 1
		ifTrue: [ ^ self ].
		
	children do: [ :child |
		| childWidthMeasureSpec childHeightMeasureSpec |
		child constraints horizontal resizer isMatchParent
			ifTrue: [ 
				| width |
				width := (anElement measuredWidth - anElement insets width - child outsets width) max: 0.
				childWidthMeasureSpec := BlMeasurementSpec exact: width ]
			ifFalse: [ 
				childWidthMeasureSpec := self
					measurementSpecFor: anExtentSpec widthSpec
					usedSize: anElement insets width + child outsets width
					resizer: child constraints horizontal resizer ].
		child constraints vertical resizer isMatchParent
			ifTrue: [ 
				| height |
				height := (anElement measuredHeight - anElement insets height - child outsets height) max: 0.
				childHeightMeasureSpec := BlMeasurementSpec exact: height ]
			ifFalse: [ 
				childHeightMeasureSpec := self
					measurementSpecFor: anExtentSpec heightSpec
					usedSize: anElement insets height + child outsets height
					resizer: child constraints vertical resizer ].
		
		child measure: childWidthMeasureSpec @ childHeightMeasureSpec ]