example
example
	| space line1 line2 attachPoint |
	
	line1 := BlLineElement new
		border: (BlBorder paint: Color red width: 2);
		yourself.

	line2 := BlLineElement new
		border: (BlBorder paint: Color blue width: 2);
		yourself.

	attachPoint := BlAttachPoint new.
	attachPoint relocate: 400 @ 200.
	attachPoint size: 10@10.

	line1 fromAnchor: (BlAbsolutePositionAnchor position: 100 @ 100).
	line1 toAnchor: (BlElementCenterAnchor element: attachPoint).

	line2 fromAnchor: (BlElementCenterAnchor element: attachPoint).
	line2 toAnchor: (BlAbsolutePositionAnchor position: 500 @ 500).
	
	space := BlSpace new.
	space root addChild: line1.
	space root addChild: line2.
	space root addChild: attachPoint.
	
	"space root addChild: (BlElement new relocate: 500@500; size: 10@10; border: (BlBorder builder paint: Color blue; width: 2; build)).
	space root addChild: (BlElement new relocate: 100@100; size: 10@10; border: (BlBorder builder paint: Color blue; width: 2; build)).
	space root addChild: (BlElement new relocate: 400@200; size: 10@10; border: (BlBorder builder paint: Color blue; width: 2; build))."
	
	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show.