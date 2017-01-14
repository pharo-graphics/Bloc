as yet unclassified
initialize
	super initialize.
	self extent: 150 @ 100.
	self border:(BlBorder paint: Color black width: 2).
		fpsShape := BlText new
		text: 'test';
		fill: Color black.
	renderTimeShape := BlText new
		text: 'test';
		fill: Color black.
	eventProcessingShape := BlText new
		text: 'test';
		fill: Color black.
		layoutingShape := BlText new
		text: 'test';
		fill: Color black.
	self
		layout: (BlLinearLayout vertical);
		addChild: fpsShape;
		addChild: renderTimeShape;
		addChild: eventProcessingShape;
		addChild: layoutingShape