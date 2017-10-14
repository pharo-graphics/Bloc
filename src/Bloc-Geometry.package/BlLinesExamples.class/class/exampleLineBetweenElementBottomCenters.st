examples
exampleLineBetweenElementBottomCenters
	| space |
	space := BlSpace new.
	space root: self new lineBetweenElementBottomCenters.

	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show