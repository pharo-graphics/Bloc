examples
exampleLineWithAnchors
	| space |
	space := BlSpace new.
	space root: self new lineWithAnchors.

	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show