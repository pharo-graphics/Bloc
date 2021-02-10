Extension { #name : #BlCircleGeometry }

{ #category : #'*Bloc-Sparta' }
BlCircleGeometry >> buildPathOnSpartaCanvas: aCanvas [
	^ aCanvas shape
		circleAt: self origin + radius asPoint
		radius: radius
]
