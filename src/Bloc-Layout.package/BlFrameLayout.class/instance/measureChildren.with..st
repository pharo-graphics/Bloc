measure
measureChildren: anElement with: anExtentSpec
	| measureMatchParentChildren matchParentChildren maxHeight maxWidth|
	
	measureMatchParentChildren := anExtentSpec isExact not.
	matchParentChildren := OrderedCollection new.
	
	maxWidth := 0.
	maxHeight := 0.

	anElement managedChildren
		select: [ :child | self isMeasureAllChildren or: [ child visibility shouldMeasure ] ]
		thenDo: [ :child | 
			self measureChildWithMargins: child parentSpec: anExtentSpec.
			maxWidth := maxWidth max: (child measuredWidth + child outsets width).
			maxHeight := maxHeight max: (child measuredHeight + child outsets height).

			(measureMatchParentChildren
				and: [ child constraints horizontal resizer isMatchParent 
					or: [ child constraints vertical resizer isMatchParent  ] ])
				ifTrue: [ matchParentChildren add: child ] ].
	
	maxWidth := maxWidth + anElement insets width.
	maxHeight := maxHeight + anElement insets height.

	maxWidth := maxWidth max: anElement constraints minWidth.
	maxHeight := maxHeight max: anElement constraints minHeight.
	
	anElement measuredExtent: (anExtentSpec sizeFor: maxWidth @ maxHeight).
	
	^ matchParentChildren