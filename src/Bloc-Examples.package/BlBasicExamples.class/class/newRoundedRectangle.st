shape creation
newRoundedRectangle
	^ (BlRectangle extent: 150@80) asElement
		background: Color brown;
		border: (BlBorder color: Color red width: 2 radius: 10);
		yourself