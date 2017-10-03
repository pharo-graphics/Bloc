example
exampleLine
	| space line attachPointFrom attachPointTo |
	
	line := BlLineElement new
		border: (BlBorder paint: Color red width: 2);
		yourself.

	attachPointFrom := BlAttachPoint new.
	attachPointFrom size: 10@10.
	attachPointFrom relocate: 100 @ 100.
	
	attachPointTo := BlAttachPoint new.
	attachPointTo size: 10@10.
	attachPointTo relocate: 400 @ 300.

	line fromAnchor: (BlElementCenterAnchor element: attachPointFrom).
	line toAnchor: (BlElementCenterAnchor element: attachPointTo).
	
	space := BlSpace new.
	space root addChild: attachPointFrom.
	space root addChild: attachPointTo.
	space root addChild: line.
	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show