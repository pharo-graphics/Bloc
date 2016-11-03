shape creation
newCircle
	^ (BlEllipse  diameter: 100) asElement
		border: (BlBorder color: Color red width: 4);
		background: (BlBackground fill: Color red);
		yourself