shape creation
newSquare
	^ (BlRectangle length:80) asElement
		background: Color green;
		border: (BlBorder color: Color black width: 2);
		yourself