examples
threeGrids
	<gtExample>
	
	^ self container
		layout: BlGridLayout horizontal;
		layoutDo: [ :l | l cellSpacing: 10 ];
		addChildren: { self gridWith11Cells . self gridWith11Cells . self gridWith11Cells }