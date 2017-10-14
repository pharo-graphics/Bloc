examples
exampleTwoLines
	| space |
	space := BlSpace new.
	space root: self new twoLines.

	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show