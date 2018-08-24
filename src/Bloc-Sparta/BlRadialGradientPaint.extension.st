Extension { #name : #BlRadialGradientPaint }

{ #category : #'*Bloc-Sparta' }
BlRadialGradientPaint >> asSpartaPaintOn: aSpartaCanvas [
	^ aSpartaCanvas paint radialGradient
		stops: self stops;
		outerCenter: self center;
		outerRadius: self radius;
		innerCenter: self focalPoint
]
