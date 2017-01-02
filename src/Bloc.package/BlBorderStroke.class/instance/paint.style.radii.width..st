private
paint: aPaint style: aBorderStrokeStyle radii: aCornerRadii width: aNumber
	paint := aPaint.
	style := aBorderStrokeStyle.
	cornerRadii := aCornerRadii.
	width := aNumber asFloat.
	self computeInnerOuterEdges.
	^ self