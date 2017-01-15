as yet unclassified
example_4El_in800x600
	| space |
	space := BlSpace new.
	0 to: 1 do: [ :y | 
		0 to: 1 do: [ :x | 
			| s currentPosition |
			currentPosition := (x * 50) @ (y * 50).
			s := BlElement new
				size: 50 @ 50;
				position: currentPosition;
				background: Color random;
				border: (BlBorder paint: Color random width: 5);
				addEventHandler: (BlOnMouseOverHandler do: [ :e | e target background: Color random ]);
				yourself.
			space root addChild: s ] ].
	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space extent: 800 @ 600.
	space show