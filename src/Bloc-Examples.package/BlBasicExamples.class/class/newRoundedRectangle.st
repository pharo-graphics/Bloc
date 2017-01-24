shape creation
newRoundedRectangle
	^ ((BlRectangle extent: 150@80) cornerRadius: 20) asElement
		background: Color yellow;
		border: (BlBorder paint: Color red width: 7);
		yourself