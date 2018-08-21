as yet unclassified
example_19200El_in800x600
	|space|
	space := BlSpace new.
	
	0 to: 120 do:[:y|
		0 to:160 do:[:x|
		|s currentPosition|	
			currentPosition := (x*5) @ (y*5).
			s := BlElement new
					size: 5@5;
					relocate: currentPosition;
					background: Color random;
					border: (BlBorder paint: Color random width: 1);
					when: BlMouseOverEvent  do:[:e| e target background:Color white];
					yourself.
			space root addChild:s
  ]].
"space root addChild: (BlFPSCounter on: space)."
space root addEventHandler: (BlEventHandler 
on:BlDoubleClickEvent do:[:evt|  BlElementSelection on: evt target. ]).
space extent: 800@600.
space show.
BlBenchmarkConsoleSpecModel onSpace: space