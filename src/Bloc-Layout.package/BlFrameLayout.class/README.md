Frame Layout is designed to block out an area on the screen to display a single item. You can have multiple elements within a FrameLayout but each element will be positioned based on the top left of the screen. Elements that overlap will be displayed overlapping.

You can add multiple children to a FrameLayout and control their position within the FrameLayout by assigning alignment to each child.

Example:

child := BlElement new
	size: 200@200;
	constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignBottom ];
	border: (BlBorder paint: Color black width: 4);
	background: Color green.
		
parent := BlElement new
	layout: BlFrameLayout new;
	size: 350@350;
	padding: (BlInsets all: 10);
	background: Color blue;
	addChild: child