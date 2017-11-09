opening
openInWindow: anElement named: aTitleString extent: aPoint
	| space |
	space := BlSpace new
		extent: aPoint;
		title: aTitleString.

	space root
		addChild: anElement;
		yourself.

	space root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	
	space show