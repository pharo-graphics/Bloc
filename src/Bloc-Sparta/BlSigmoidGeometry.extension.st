Extension { #name : #BlSigmoidGeometry }

{ #category : #'*Bloc-Sparta' }
BlSigmoidGeometry >> buildPathOnSpartaCanvas: aCanvas [
	^ aCanvas path
		moveTo: from;
		curveVia: fromControl
			and: toControl
			to: to;
		build
]
