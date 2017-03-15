measure
measureChildren: anElement with: anExtentSpec
	| availableWidth availableHeight |
	
	availableWidth := anElement measuredWidth - anElement insets width.
	availableHeight := anElement measuredHeight - anElement insets height.
	
	anElement managedChildren
		select: [ :aChild | aChild visibility shouldMeasure ]
		thenDo: [ :aChild | 
			| childWidthSpec childHeightSpec |

			childWidthSpec := aChild constraints horizontal resizer isMatchParent
				ifTrue: [ 
					BlMeasurementSpec exact: ((availableWidth - aChild outsets width) max: 0) ]
				ifFalse: [ self
						measurementSpecFor: anExtentSpec widthSpec
						usedSize: anElement insets width + aChild outsets width
						resizer: aChild constraints horizontal resizer ].
			
			childHeightSpec := aChild constraints vertical resizer isMatchParent
				ifTrue: [ 
					BlMeasurementSpec exact: ((availableHeight - aChild outsets height) max: 0) ]
				ifFalse: [ self
						measurementSpecFor: anExtentSpec heightSpec
						usedSize: anElement insets height + aChild outsets height
						resizer: aChild constraints vertical resizer ].
		
				aChild measure: childWidthSpec @ childHeightSpec ]