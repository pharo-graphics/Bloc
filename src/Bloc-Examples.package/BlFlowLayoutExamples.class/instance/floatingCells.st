examples - list with floats
floatingCells
	<gtExample>
	
	^ self container
		size: 560@400;
		relocate: 100 @ 50;
		addChildren: (2 timesCollect: [ self grayCell ]);
		addChild: self floatRedCell;
		addChildren: (30 timesCollect: [ self redCell ]);
		addChild: self floatBlueCell;
		addChildren: (4 timesCollect: [ self blueCell ]);
		yourself