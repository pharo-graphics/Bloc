shape creation
newRoundedRectangle
	^ (BlRectangle extent: 150@80) asElement
		background: Color brown;
		border: (BlBorder paint: Color red width: 2);
		yourself