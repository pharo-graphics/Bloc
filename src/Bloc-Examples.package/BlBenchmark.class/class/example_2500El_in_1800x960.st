as yet unclassified
example_2500El_in_1800x960
	|sp|
	sp := BlSpace new.
	0 to: 50 do:[:y|
		0 to:50 do:[:x|
		|s currentPosition|	
			currentPosition := (x*50) @ (y*50).
			s := BlElement new
					extent: 50@50;
					position: currentPosition;
					background: Color random;
					border: (BlBorder color:Color random width:2);
					addEventHandler: (BlOnMouseOverHandler do:[:e| e target background: Color random]);
					yourself.
			sp root addChild:s
  ]].
sp root addEventHandler: (BlEventHandler 
on:BlDblClickEvent do:[:evt|  BlElementSelection on: evt target. ]).
sp extent: 1800@960.
sp show.

BlBenchmarkConsoleSpecModel onSpace: sp