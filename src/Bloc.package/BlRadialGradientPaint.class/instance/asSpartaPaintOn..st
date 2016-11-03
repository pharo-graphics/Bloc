as yet unclassified
asSpartaPaintOn: aSpartaCanvas
	^ aSpartaCanvas paintProvider radialGradient
		stops: self stops;
		innerCenter: self center;
		innerRadius: self radius
		