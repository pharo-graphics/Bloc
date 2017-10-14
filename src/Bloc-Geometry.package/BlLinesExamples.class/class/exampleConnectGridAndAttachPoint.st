examples
exampleConnectGridAndAttachPoint
	| space |
	space := BlSpace new.
	space root: self new connectGridWith12Lines.
	
	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show