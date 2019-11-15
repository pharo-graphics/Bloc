Extension { #name : #BlSigmoid }

{ #category : #'*Bloc-Sparta' }
BlSigmoid >> buildPathOnSpartaCanvas: aCanvas [
	^ aCanvas path
		moveTo: from;
		curveVia: fromControl
			and: toControl
			to: to;
		build
]
