as yet unclassified
example_4800El_in800x600
	|space|
	space := BlSpace new.
	
	0 to: 60 do:[:y|
		0 to:80 do:[:x|
		|s currentPosition|	
			currentPosition := (x*10) @ (y*10).
			s := BlElement new
					size: 10@10;
					position: currentPosition;
					background: Color random;
					border: (BlBorder paint: Color random width: 1);
					when: BlMouseOverEvent do:[:e| e target background: Color random];
					yourself.
			space root addChild:s
  ]].
"space root addChild: (BlFPSCounter on: space)."
space root addEventHandler: (BlEventHandler 
on:BlDoubleClickEvent do:[:evt|  BlElementSelection on: evt target. ]).
space extent: 800@600.
space show.
BlBenchmarkConsoleSpecModel onSpace: space