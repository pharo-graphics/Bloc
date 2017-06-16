*Bloc-Sparta
asSpartaPaintOn: aSpartaCanvas
	^ aSpartaCanvas paint radialGradient
		stops: self stops;
		innerCenter: self center;
		innerRadius: self radius