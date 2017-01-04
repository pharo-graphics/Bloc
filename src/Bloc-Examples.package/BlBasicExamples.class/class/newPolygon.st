shape creation
newPolygon
	^ (BlPolygon vertices:{100@10. 40@198. 190@78. 10@78. 160@198}) asElement
		size: 200@200;
		background: Color blue;
		border: (BlBorder color: Color darkGray width: 2);
		yourself