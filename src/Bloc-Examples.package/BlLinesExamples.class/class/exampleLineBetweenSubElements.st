examples
exampleLineBetweenSubElements
	| space |
	space := BlSpace new.
	space root: self new lineBetweenSubElements.

	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show