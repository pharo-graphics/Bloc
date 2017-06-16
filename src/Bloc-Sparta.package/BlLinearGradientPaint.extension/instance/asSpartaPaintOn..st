*Bloc-Sparta
asSpartaPaintOn: aSpartaCanvas
	^ aSpartaCanvas paint linearGradient
		stops: self stops;
		begin: self start;
		end: self end