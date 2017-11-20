examples - border
elementWithEllipticBorders
	<gtExample>
	
	^ self container
		layout: BlFrameLayout new;
		size: 300@150;
		relocate: 50@50;
		addChild: (self leftBorder background: (Color gray alpha: 0.3); geometry: BlEllipse new);
		addChild: (self rightBorder background: (Color gray alpha: 0.3); geometry: BlEllipse new);
		addChild: (self topBorder background: (Color gray alpha: 0.3); geometry: BlEllipse new);
		addChild: (self bottomBorder background: (Color gray alpha: 0.3); geometry: BlEllipse new);
		addChild: self borderText