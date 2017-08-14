measure
measureChildren: anElement with: anExtentSpec
	"Perform a first measurement pass and measure those children for which we can
	determine an extent, otherwise add children to a collection that should be
	measured during second pass and return it"
	<return: #LinkedList of: #BlElement>
	| measureMatchParentChildren matchParentChildren maxHeight maxWidth |
	
	matchParentChildren := LinkedList new.
	
	"true if children matching parent should be measured in first pass"	
	measureMatchParentChildren := anExtentSpec isExact.

	maxWidth := 0.
	maxHeight := 0.

	self
		measuredChildren: anElement
		do: [ :aChild |
			| shouldMeasureChild |
			
			"true if aChild should be measured NOW or during second measurement pass
			we measure children if parent is exact or if child is not matching parent"
			shouldMeasureChild := measureMatchParentChildren
				or: [ aChild constraints horizontal resizer isMatchParent not
					and: [ aChild constraints vertical resizer isMatchParent not ] ].
		
			shouldMeasureChild
				"measure now"
				ifTrue: [
					self measureChildWithMargins: aChild parentSpec: anExtentSpec.
					maxWidth := maxWidth max: (aChild measuredWidth + aChild outsets width).
					maxHeight := maxHeight max: (aChild measuredHeight + aChild outsets height) ]
				"or during second pass"
				ifFalse: [ matchParentChildren add: aChild ] ].
	
	maxWidth := maxWidth + anElement insets width.
	maxHeight := maxHeight + anElement insets height.

	maxWidth := maxWidth max: anElement constraints minWidth.
	maxHeight := maxHeight max: anElement constraints minHeight.
	
	anElement measuredExtent: (anExtentSpec sizeFor: maxWidth @ maxHeight).
	
	^ matchParentChildren