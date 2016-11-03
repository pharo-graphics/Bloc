path building
buildPathOn: aPathBuilder within: aBounds
	| aCollection |
	aCollection := self verticesForBounds: aBounds.
	aPathBuilder
		absolute;
		moveTo: aCollection first.
	aCollection do: [ :pt | aPathBuilder lineTo: pt ].
	aPathBuilder close