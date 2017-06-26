shape examples
example3D
	| space |
	space := BlSpace new
		extent: 600 @ 450;
		title: 'Shape example'.

	space root
		addChild: (BlElementExampleCubeOpenGL new size: 550@400; position: 25@25; background: (Color gray alpha: 0.2));
		yourself.

	space root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	
	space show