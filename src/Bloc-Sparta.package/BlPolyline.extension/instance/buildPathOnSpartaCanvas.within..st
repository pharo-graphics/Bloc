*Bloc-Sparta
buildPathOnSpartaCanvas: aCanvas within: aBounds
	| aCollection pathBuilder |
	
	aCollection := self vertices.
	
	pathBuilder := aCanvas path
		absolute;
		moveTo: aCollection first.
	aCollection do: [ :pt | pathBuilder lineTo: pt ].
	
	^ pathBuilder finish