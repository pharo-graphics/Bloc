custom root
exampleSpaceRootIsAnEllipse
	| space root child |
	
	space := BlSpace new
		title: 'Ellipse Shape example'.
	
	root := 	BlElement new
		geometry: BlEllipse new;
		background: Color yellow;
		yourself.
	
	child := BlElement new
		background: Color red;
		size: 400@400;
		yourself.
	
	space root: root.
	space root addChild: child.
	
	space root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	
	space show