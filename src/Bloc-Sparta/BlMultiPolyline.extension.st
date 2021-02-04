Extension { #name : #BlMultiPolyline }

{ #category : #'*Bloc-Sparta' }
BlMultiPolyline >> buildPathOnSpartaCanvas: aCanvas [
	| pathBuilder |
	
	pathBuilder := aCanvas path absolute.

	self polylines do: [ :eachPolygon |
		pathBuilder moveTo: eachPolygon first.
		eachPolygon do: [ :pt | pathBuilder lineTo: pt ] ].

	^ pathBuilder finish
]
