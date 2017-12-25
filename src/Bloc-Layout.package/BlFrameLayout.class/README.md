! Frame layout

Frame Layout is designed to block out an area on the screen to display a single item. You can have multiple elements within a FrameLayout but each element will be positioned based on the top left of the screen. 

!! Alignment
You can add multiple children to a FrameLayout and control their position within the FrameLayout by assigning alignment to each child.

Example of a child in the bottom right corner:

[[[
| child parent |
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
	addChild: child.
]]]


!! Weight
Children that match parent can also be configured to occupy only a fraction of parent's size by providing a weight [0...N]
Example:

[[[
| child parent |
child := BlElement new.
child background: Color red.
child constraintsDo: [ :c |
	c horizontal matchParent.
	c vertical matchParent.
	c frame horizontal alignCenter; weight: 0.3.
	c frame vertical alignCenter; weight: 0.5 ].

parent := BlElement new.
parent layout: BlFrameLayout new.
parent size: 300@300.
parent background: (Color gray alpha: 0.5).
parent addChild: child.
parent
]]]