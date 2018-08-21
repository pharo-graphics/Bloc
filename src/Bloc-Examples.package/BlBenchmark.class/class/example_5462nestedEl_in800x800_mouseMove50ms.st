nested bench
example_5462nestedEl_in800x800_mouseMove50ms
	|space child anim|
	space := BlSpace new.
	child := self createSquareAnd4SubSquaresLength: 800 min: 15.

space root addChild: child.	
"space root addChild: (BlFPSCounter on: space)."
space root addEventHandler: (BlEventHandler 
on:BlDoubleClickEvent do:[:evt|  BlElementSelection on: evt target. ]).


anim := BlAnimation new
	delay:15;
	duration:1;
	loops:500;
	onFinishedDo: [ 
		|pos|
		pos := (750 atRandom)@(750 atRandom).
		space hostSpace ifNil:[^ self].
		space hostSpace enqueueEvent: (BlMouseMoveEvent new
		position: pos).
		
	 ].
child userData at: #anim put: anim.

space extent: 800@800.
space show.
anim start.
BlBenchmarkConsoleSpecModel onSpace: space