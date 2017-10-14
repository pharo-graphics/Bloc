examples
exampleConnectTwoGrids
	| space |
	space := BlSpace new.
	space root: self new connectTwoGridsWith6Lines.

	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show