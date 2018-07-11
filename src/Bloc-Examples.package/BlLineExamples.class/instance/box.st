instance creation
box
	<gtExample>
	
	^ BlElement new
		size: 100@100;
		background: (Color gray alpha: 0.3);
		border: (BlBorder builder width: 1; paint: Color gray; build);
		layout: BlFrameLayout new;
		addEventHandler: BlPullHandler new;
		yourself.