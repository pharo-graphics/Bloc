Extension { #name : #BlMultiPolygonGeometry }

{ #category : #'*Bloc-Sparta' }
BlMultiPolygonGeometry >> buildPathOnSpartaCanvas: aCanvas [
	| pathBuilder |
	
	pathBuilder := aCanvas path absolute.

	self polygons do: [ :eachPolygon |
		pathBuilder moveTo: eachPolygon first.
		eachPolygon do: [ :eachPoint | pathBuilder lineTo: eachPoint ].
		pathBuilder lineTo: eachPolygon first ].

	^ pathBuilder finish
]
