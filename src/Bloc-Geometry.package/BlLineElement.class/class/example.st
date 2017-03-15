example
example
	| space line1 line2 |
	
	line1 := BlLineElement new
		border: (BlBorder paint: Color red width: 2);
		showAttachPoints;
		yourself.
		
	line2 := BlLineElement new
		border: (BlBorder paint: Color blue width: 2);
		showAttachPoints;
		yourself.

	line1 fromAnchor: (BlGeometryStaticAnchor position: 100 @ 100).
	line1 toAnchor: (BlGeometryAttachPointAnchor attachPoint: line2 fromAttach).

	line2 fromAnchor: (BlGeometryStaticAnchor position: 400 @ 200).
	line2 toAnchor: (BlGeometryStaticAnchor position: 500 @ 500).
	
	space := BlSpace new.
	space root addChild: line1.
	space root addChild: line2.
	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show