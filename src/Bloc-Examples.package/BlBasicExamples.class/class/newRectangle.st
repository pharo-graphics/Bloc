shape creation
newRectangle
	^ (BlRectangle extent: 200 @ 100) asElement
		background: Color transparent;
		border: (BlBorder paint: Color blue width: 4);
		yourself