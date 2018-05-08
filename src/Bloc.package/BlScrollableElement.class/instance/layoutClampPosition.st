layout
layoutClampPosition
	| aCurrentPositionX aContent aMinPositionX aMaxPositionX aNewClampedPositionX aCurrentPositionY aMinPositionY aMaxPositionY aNewClampedPositionY |
	
	aContent := self scrolledElement.
	
	aCurrentPositionX := scrollPosition x.
	aMinPositionX := (self width - aContent measuredWidth) min: 0.
	aMaxPositionX := 0.
	aNewClampedPositionX := (aCurrentPositionX max: aMinPositionX) min: aMaxPositionX.
	
	aCurrentPositionY := scrollPosition y.
	aMinPositionY := (self height - aContent measuredHeight) min: 0.
	aMaxPositionY := 0.
	aNewClampedPositionY := (aCurrentPositionY max: aMinPositionY) min: aMaxPositionY.
	scrollPosition := aNewClampedPositionX @ aNewClampedPositionY.

	aContent measuredBounds position: scrollPosition.