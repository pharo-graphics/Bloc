as yet unclassified
asSpartaPaintOn: aSpartaCanvas
	^ aSpartaCanvas paintProvider linearGradient
		stops: self stops;
		begin: self start;
		end: self end