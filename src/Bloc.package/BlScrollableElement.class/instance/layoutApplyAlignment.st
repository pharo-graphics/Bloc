layout
layoutApplyAlignment
	| aContent |
	
	aContent := self scrolledElement.
	
	(aContent measuredWidth < self width)
		ifTrue: [
			| aHorizontalTranslation |
			aHorizontalTranslation := (self horizontalAlignment translationOf: aContent measuredBounds bounds in: self bounds inLocal bounds) x.
			scrollPosition := scrollPosition + (aHorizontalTranslation @ 0) ].
		
	(aContent measuredHeight < self height)
		ifTrue: [
			| aVerticalTranslation |
			aVerticalTranslation := (self verticalAlignment translationOf: aContent measuredBounds bounds in: self bounds inLocal bounds) y.
			scrollPosition := scrollPosition + (0 @ aVerticalTranslation) ].
	
	aContent measuredBounds position: scrollPosition