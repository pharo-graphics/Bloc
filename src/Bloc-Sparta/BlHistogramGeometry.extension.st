Extension { #name : #BlHistogramGeometry }

{ #category : #'*Bloc-Sparta' }
BlHistogramGeometry >> buildPathOnSpartaCanvas: aCanvas [
	| aBuilder anOrigin aDelta aLengthVector |
	
	self values
		ifEmpty: [ ^ self geometryBounds ].
	
	anOrigin := self computeOrigin asFloatPoint.
	aDelta := self computeDelta.
	aLengthVector := self computeLengthVector.

	aBuilder := aCanvas path.
	aBuilder moveTo: anOrigin.

	self values inject: anOrigin into: [ :currentPoint :eachValue |
		| aNewY |
		
		aNewY := currentPoint + aDelta.
		aBuilder
			lineTo: currentPoint + (aLengthVector * eachValue * self extent);
			lineTo: aNewY + (aLengthVector * eachValue * self extent).
		aNewY ].
	aBuilder lineTo: anOrigin + (aDelta normalized * self extent).
	aBuilder close.

	^ aBuilder build
]
