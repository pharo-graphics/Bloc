example
exampleLineBetweenElementsCorners
	| space line attachPoint1 attachPoint2 element1 element2 |

	line := BlLineElement new
		border: (BlBorder paint: Color red width: 2);
		showAttachPoints;
		yourself.

	attachPoint1 := BlAttachPoint new
		size: 0@0;
		position: 100 @ 100;
		constraintsDo: [ :c |
			c frame horizontal alignRight.
			c frame vertical alignCenter ].

	element1 := BlElement new
		size: 100@100;
		relocate: 50@50;
		background: (Color blue alpha: 0.5);
		border: (BlBorder builder width: 1; paint: Color blue; build);
		layout: BlFrameLayout new;
		addChild: attachPoint1;
		yourself.
	
	attachPoint2 := BlAttachPoint new
		size: 0@0;
		constraintsDo: [ :c |
			c frame horizontal alignLeft.
			c frame vertical alignBottom ].
	element2 := BlElement new
		size: 100@100;
		relocate: 250@250;
		background: (Color green alpha: 0.5);
		border: (BlBorder builder width: 1; paint: Color green muchDarker; build);
		layout: BlFrameLayout new;
		addChild: attachPoint2;
		yourself.

	line fromAnchor: (BlElementCenterAnchor element: attachPoint1).
	line toAnchor: (BlElementCenterAnchor element: attachPoint2).
	
	space := BlSpace new.
	space root addChild: line.
	space root addChild: element1.
	space root addChild: element2.
	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show