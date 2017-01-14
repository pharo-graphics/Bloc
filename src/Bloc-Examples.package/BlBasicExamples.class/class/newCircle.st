shape creation
newCircle
	^ (BlEllipse  diameter: 100) asElement
		background: (Color red alpha: 0.8);
		border: (BlBorder paint: (Color blue alpha: 0.5) width: 6);
		yourself