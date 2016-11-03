*Bloc-Sparta
buildPathOnSpartaCanvas: aCanvas within: aBounds
	
	| aCollection pathBuilder |
	aCollection := self verticesForBounds: aBounds.
	pathBuilder := aCanvas path
		absolute;
		moveTo: aCollection first.
	aCollection do: [ :pt | pathBuilder lineTo: pt ].
	pathBuilder close.
	^ pathBuilder finish