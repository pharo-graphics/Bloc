examples - drag
draggableInParent
	<gtExample>
	
	^ self container
		relocate: 50@50;
		addChild: (self draggable relocate: 75@60);
		yourself