layout
layout: anElement in: aRectangle
	| maxPoint |
	super layout: anElement in: aRectangle.
	anElement hasChildren ifFalse:[^self].
	
	maxPoint:= anElement visualBoundsInParent corner.
	anElement managedChildrenDo: [ :child |	maxPoint := maxPoint max: child visualBoundsInParent corner.].
	anElement size: maxPoint.