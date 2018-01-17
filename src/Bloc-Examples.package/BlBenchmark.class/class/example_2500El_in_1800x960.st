as yet unclassified
example_2500El_in_1800x960
	|sp|
	sp := BlSpace new.
	0 to: 50 do:[:y|
		0 to:50 do:[:x|
		|s currentPosition|	
			currentPosition := (x*50) @ (y*50).
			s := BlElement new
					size: 50@50;
					relocate: currentPosition;
					background: Color random;
					border: (BlBorder paint: Color random width: 2);
					when: BlMouseOverEvent do:[:e| e target background: Color random];
					yourself.
			sp root addChild: s
  ]].
sp root addEventHandler: (BlEventHandler 
on:BlDblClickEvent do:[:evt|  BlElementSelection on: evt target. ]).
sp extent: 1800@960.
sp show.

BlBenchmarkConsoleSpecModel onSpace: sp