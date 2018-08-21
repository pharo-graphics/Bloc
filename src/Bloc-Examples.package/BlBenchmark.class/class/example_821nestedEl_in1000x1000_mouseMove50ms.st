nested bench
example_821nestedEl_in1000x1000_mouseMove50ms
	|space child anim|
	space := BlSpace new.
	child := self createSquareAnd9SubSquaresLength: 1000 min: 50.

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
		pos := (900 atRandom)@(900 atRandom).
		space hostSpace ifNil: [ ^ self ].
		space hostSpace enqueueEvent: (BlMouseMoveEvent new position: pos) ].
child userData at: #anim put: anim.

space extent: 1000@1000.
space show.
anim start.
BlBenchmarkConsoleSpecModel onSpace: space