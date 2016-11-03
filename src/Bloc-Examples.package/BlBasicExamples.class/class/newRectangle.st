shape creation
newRectangle
	^ (BlRectangle extent: 200 @ 100) asElement
		background: Color yellow;
		border: (BlBorder color: Color blue width: 4);
		yourself