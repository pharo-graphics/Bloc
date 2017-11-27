layout
layoutBounds
	<return: #Rectangle>
	| aCenterPosition anOrigin aCorner|
	
	aCenterPosition := self centerPosition.
	anOrigin := aCenterPosition - (self majorRadius @ self minorRadius).
	aCorner := aCenterPosition + (self majorRadius @ self minorRadius).
	
	^ anOrigin corner: aCorner