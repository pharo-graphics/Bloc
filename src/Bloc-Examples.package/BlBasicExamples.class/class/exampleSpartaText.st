shape examples
exampleSpartaText
	| space txt  |
	BlUniverse default useOSWindowSpartaHost.
	
	space := BlSpace new
		extent: 600 @ 350;
		title: 'Text example'.
	
	txt := BlSpartaText new
		wrappingWidth: 250;
		position:200@100;
		fill: Color blue;
		stroke: Color green;
		text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sodales tempus porttitor. Donec ac lacus luctus, malesuada ligula in, gravida sapien. Sed varius nibh eget convallis accumsan'.

	space root
		addChild: (BlBenchmarkConsole on:space);
		addChildren:{txt}.
	
	space root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	
	space show.
	
	