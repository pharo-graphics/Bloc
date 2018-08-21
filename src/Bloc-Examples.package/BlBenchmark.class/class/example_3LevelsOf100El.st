as yet unclassified
example_3LevelsOf100El
	|space|
	space := BlSpace new.
	1 to:3 do:[:i|
		0 to: 10 do:[:y|
			0 to:10 do:[:x|
			|s currentPosition|	
				currentPosition := (x*50) @ (y*50).
				s := BlElement new
					size: 50@50;
					relocate: currentPosition;
					background: Color random;
					border: (BlBorder paint: Color random width:2);
					yourself.
				space root addChild:s
  ]]].
"space root addChild: (BlFPSCounter on:space)."
space root addEventHandler: (BlEventHandler 
on:BlDoubleClickEvent do:[:evt|  BlElementSelection on: evt target. ]).
space show.
BlBenchmarkConsoleSpecModel onSpace: space