nested bench
example_21846nestedEl_in800x800_mouseMove50ms
	|space child anim|
	space := BlSpace new.
	child := self createSquareAnd4SubSquaresLength: 800 min: 5.

space root addChild: child.	
"space root addChild: (BlFPSCounter on: space)."
space root addEventHandler: (BlEventHandler 
on:BlDoubleClickEvent do:[:evt|  BlElementSelection on: evt target. ]).


"anim := BlAnimation new
	delay:15;
	duration:1;
	cycleCount:500;
	onPerformedDo: [ 
		|pos|
		pos := (750 atRandom)@(750 atRandom).
		space hostWindow ifNil:[^ self].
		space hostWindow eventFetcher enqueue: (BlMouseMoveEvent new
		position: pos).
		
	 ].
child userData at: #anim put: anim."

space extent: 800@800.
space show.
"anim start.
BlDevToolSpecModel onSpace: space"