examples - shape
polygon
	<gtExample>
	
	^ (BlPolygon vertices: { 100@10. 40@198. 190@78. 10@78. 160@198} ) asElement
		size: 200@200;
		background: (Color blue alpha: 0.4);
		outskirts: BlOutskirts outside;
		border: (BlBorder
			paint: Color darkGray
			width: 2);
		yourself