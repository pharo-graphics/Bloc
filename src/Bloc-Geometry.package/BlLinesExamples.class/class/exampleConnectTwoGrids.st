examples
exampleConnectTwoGrids
	| space |
	space := BlSpace new.
	space root: (BlLinesExamples>>#connectGrid:andGrid:in:with:with:with:with:with:with:) gtExample returnValue.

	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show