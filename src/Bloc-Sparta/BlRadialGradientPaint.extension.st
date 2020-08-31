Extension { #name : #BlRadialGradientPaint }

{ #category : #'*Bloc-Sparta' }
BlRadialGradientPaint >> asSpartaPaintOn: aSpartaCanvas [
	^ aSpartaCanvas paint radialGradient
		stops: self stops;
		center: self center;
		radius: self radius
]
