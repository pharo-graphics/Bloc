examples
exampleClasses
	| space list container controls  smoothScrollBy smoothScrollByNegated |
	space := BlSpace new
		extent: 500 @ 650;
		title: 'Smalltalk allClasses'.
		
	container := BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c padding: (BlInsets top: 5) ];
		yourself.	
	
	controls := BlElement new
		layout: (BlGridLayout vertical cellSpacing: 5);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.	
	
	list := BlInfiniteExampleClassesListElement new
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical matchParent ];
		yourself.
	
	smoothScrollBy := BlInfiniteExampleControlElement new
		label: 'Smooth down';
		background: Color veryLightGray;
		extent: 200@40;
		addEventHandlerOn: BlClickEvent do: [ list smoothScrollBy: 0@400 ];
		yourself.
		
	smoothScrollByNegated := BlInfiniteExampleControlElement new
		label: 'Smooth up';
		background: Color veryLightGray;
		extent: 200@40;
		addEventHandlerOn: BlClickEvent do: [ list smoothScrollBy: 0@400 negated ];
		yourself.
	
	controls addChildren: { smoothScrollByNegated .smoothScrollBy }.
	container addChildren: { list . "controls" }.
	
	space root addChild: container.
	"space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ])."
	space show