Extension { #name : #BlCircle }

{ #category : #'*Bloc-Sparta' }
BlCircle >> buildPathOnSpartaCanvas: aCanvas [
	^ aCanvas shape
		circleAt: self origin + radius asPoint
		radius: radius
]
