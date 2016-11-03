private
paint: aPaint style: aBorderStrokeStyle radii: aCornerRadii width: aNumber
	paint := aPaint.
	style := aBorderStrokeStyle.
	cornerRadii := aCornerRadii.
	width := aNumber.
	self computeInnerOuterEdges.
	^ self