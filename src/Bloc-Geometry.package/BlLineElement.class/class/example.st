example
example
	| space line1 line2 attachPoint |
	
	line1 := BlLineElement new
		border: (BlBorder paint: Color red width: 2);
		showAttachPoints;
		yourself.

	line2 := BlLineElement new
		border: (BlBorder paint: Color blue width: 2);
		showAttachPoints;
		yourself.
		
	attachPoint := BlAttachPoint new.
	attachPoint position: 400 @ 200.

	line1 fromAnchor: (BlAbsolutePositionAnchor position: 100 @ 100).
	line1 toAnchor: (BlElementRelativeAnchor attachPoint: attachPoint).

	line2 fromAnchor: (BlElementRelativeAnchor attachPoint: line1 toAttach).
	line2 toAnchor: (BlAbsolutePositionAnchor position: 500 @ 500).
	
	space := BlSpace new.
	space root addChild: attachPoint.
	space root addChild: line1.
	space root addChild: line2.
	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show