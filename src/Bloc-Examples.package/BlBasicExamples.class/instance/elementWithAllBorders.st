examples - border
elementWithAllBorders
	<gtExample>
	
	^ self container
		layout: BlFrameLayout new;
		size: 300@150;
		relocate: 50@50;
		addChild: (self leftBorder background: Color green darker);
		addChild: (self rightBorder background: Color yellow darker);
		addChild: (self topBorder background: Color blue);
		addChild: (self bottomBorder background: Color red)