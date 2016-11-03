layout
layout: anElement in: newBounds
	| offset maxHeight |
	offset := 0 @ 0.
	maxHeight := 0.
	anElement
		managedChildrenDo: [ :component | 
			offset x + component measuredWidth > newBounds width
				ifTrue: [ 
					offset := 0 @ (offset y + maxHeight).
					maxHeight := 0 ].	"start a new line"
			component relocate: offset.
			maxHeight := maxHeight max: component measuredHeight.
			offset := (offset x + component measuredWidth) @ offset y ].
	maxHeight + offset y > anElement measuredHeight
		ifTrue: [ anElement measuredExtent: anElement measuredWidth @ (maxHeight + offset y) ]