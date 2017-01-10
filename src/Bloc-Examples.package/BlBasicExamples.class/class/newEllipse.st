shape creation
newEllipse
	^ (BlEllipse extent: 200 @ 100) asElement
		background: (Color red alpha: 0.5);
		border: (BlBorder color: Color black width: 2);
		yourself