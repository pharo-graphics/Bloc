examples
exampleLineBetweenElementCenters
	| space |
	space := BlSpace new.
	space root: self new lineBetweenElementCenters.

	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show