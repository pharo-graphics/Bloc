example
exampleLineBetweenElements
	| space line element1 element2 |

	line := BlLineElement new
		border: (BlBorder paint: Color red width: 2);
		showAttachPoints;
		yourself.
	
	element1 := BlElement new
		size: 100@100;
		position: 50@50;
		background: (Color blue alpha: 0.5);
		border: (BlBorder builder width: 1; paint: Color blue; build);
		layout: BlFrameLayout new;
		yourself.
	

	element2 := BlElement new
		size: 100@100;
		position: 250@250;
		background: (Color green alpha: 0.5);
		border: (BlBorder builder width: 1; paint: Color green muchDarker; build);
		layout: BlFrameLayout new;
		yourself.

	
	space := BlSpace new.
	space root addChild: line.
	space root addChild: element1.
	space root addChild: element2.
	
	space root forceLayout.
	
	line fromAnchor: (BlElementCenterBottomAnchor element: element1).
	line toAnchor: (BlElementCenterBottomAnchor element: element2).
	
	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show