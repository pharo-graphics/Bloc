examples
open
	<example>
	| space chicken |
	
	space := BlSpace new.
	space extent: 500 @ 500.
	space title: 'Software chicken'.
	
	chicken := BlChicken new.
	chicken size: 300 @ 350.
	space root addChild: chicken.
	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show