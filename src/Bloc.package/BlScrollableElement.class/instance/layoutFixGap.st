layout
layoutFixGap
	| aContent aGapX aGapY |
	
	aContent := self scrolledElement.
	
	aGapX := (self width - aContent measuredBounds bounds right) max: 0.
	scrollPosition x < 0
		ifTrue: [
			| aNewX |
			aNewX := (scrollPosition x + aGapX) min: 0.
			scrollPosition := aNewX @ scrollPosition y ].
	
	aGapY := (self height - aContent measuredBounds bounds bottom) max: 0.	
	scrollPosition y < 0
		ifTrue: [
			| aNewY |
			aNewY := (scrollPosition y + aGapY) min: 0.
			scrollPosition := scrollPosition x @ aNewY ].

	aContent measuredBounds position: scrollPosition