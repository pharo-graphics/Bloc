Extension { #name : #BlPolygon }

{ #category : #'*Bloc-Sparta' }
BlPolygon >> buildPathOnSpartaCanvas: aCanvas [
	| aCollection pathBuilder |
	aCollection := self vertices.
	pathBuilder := aCanvas path
		absolute;
		moveTo: aCollection first.
	aCollection allButFirstDo: [ :pt | pathBuilder lineTo: pt ].
	pathBuilder close.
	^ pathBuilder finish
]
