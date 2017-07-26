examples
exampleConnectGridAndAttachPoint
	| space |
	space := BlSpace new.
	space root: (BlLinesExamples>>#connectGrid:and:in:with:with:with:with:with:with:with:with:with:with:with:with:) gtExample returnValue.
	
	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show