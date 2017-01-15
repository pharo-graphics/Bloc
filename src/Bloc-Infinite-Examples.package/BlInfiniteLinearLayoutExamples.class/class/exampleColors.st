examples
exampleColors
	| space list container controls smoothScrollToFirst smoothScrollToLast smoothScrollBy smoothScrollByNegated |
	space := BlSpace new
		extent: 800 @ 650;
		title: 'Infinite list example'.

	container := BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.	
	
	controls := BlElement new
		layout: (BlGridLayout vertical cellSpacing: 5);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.	
	
	list := BlInfiniteExampleColorsListElement new
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical matchParent ];
		yourself.
		
	smoothScrollToFirst := BlInfiniteExampleControlElement new
		label: 'Smooth to first';
		background: Color veryLightGray;
		extent: 200@40;
		addEventHandlerOn: BlClickEvent do: [ list smoothScrollToPosition: 1 ];
		yourself.
	
	smoothScrollToLast := BlInfiniteExampleControlElement new
		label: 'Smooth to last';
		background: Color veryLightGray;
		extent: 200@40;
		addEventHandlerOn: BlClickEvent do: [ list smoothScrollToPosition: list dataSource itemCount ];
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
	
	controls addChildren: { smoothScrollToFirst . smoothScrollToLast . smoothScrollByNegated .smoothScrollBy }.
	container addChildren: { list . controls }.
	
	space root addChild: container.
	"space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ])."
	space show