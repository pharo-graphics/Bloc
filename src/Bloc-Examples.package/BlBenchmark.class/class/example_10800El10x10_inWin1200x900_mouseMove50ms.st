as yet unclassified
example_10800El10x10_inWin1200x900_mouseMove50ms
	|space anim|
	space := BlSpace new.
	
	0 to: 90 do:[:y|
		0 to: 120 do:[:x|
		|s currentPosition|	
			currentPosition := (x*10) @ (y*10).
			s := BlElement new
					size: 10@10;
					relocate: currentPosition;
					background: Color random;
					border: (BlBorder paint: Color random width: 1);
					addEventHandler: (BlOnMouseOverHandler do:[:e| e target background: Color random]);
					yourself.
			space root addChild:s
  ]].
"space root addChild: (BlFPSCounter on: space)."
space root addEventHandler: (BlEventHandler 
on:BlDblClickEvent do:[:evt|  BlElementSelection on: evt target. ]).


anim := BlAnimation new
	delay:50;
	duration:1;
	loop:100;
	onFinishedDo: [ 
		|pos|
		pos := (750 atRandom)@(750 atRandom).
		space eventListener handleEvent: (BlMouseMoveEvent new
		position: pos).
		
	 ].
space root userData at: #anim put: anim.

space extent: 1024@768.
space show.
anim start.
BlBenchmarkConsoleSpecModel onSpace: space