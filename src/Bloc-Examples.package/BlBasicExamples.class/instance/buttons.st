examples - buttons
buttons
	<gtExample>
	
	^ self container
		addChild: (self coloredButton relocate: 100@100);
		addChild: (self fabButton relocate: 300@88);
		yourself