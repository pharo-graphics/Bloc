shape creation
newEllipse
	^ (BlEllipse extent: 200 @ 100) asElement
		background: Color red asBlBackground;
		border: (BlBorder color: Color black width: 2);
		yourself