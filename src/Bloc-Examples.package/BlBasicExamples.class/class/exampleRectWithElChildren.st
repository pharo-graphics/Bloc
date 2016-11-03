element examples
exampleRectWithElChildren
	|c1 c2 sp p |
	
	c1 := BlElement new
		extent: 80 @ 80;
		background:(BlBackground fill: Color green).
	
	c2 := BlElement new
		extent: 80 @ 80;
		background:(BlBackground fill: Color red).
	
	
	p := BlElement new
		layout: BlLinearLayout vertical;
		extent: 200 @ 300;
		position: 200@100;
		background:(BlBackground fill: Color blue);
		addChild: c1;
		addChild: c2.
		
	sp := BlSpace new.
	sp root addChild: p.
	"sp root addChild: (BlFPSCounter on:sp)."
	sp root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	sp show