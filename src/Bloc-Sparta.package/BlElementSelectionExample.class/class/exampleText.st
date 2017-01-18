example
exampleText
	<example>
	| aContainer aSpace |

	aContainer := self createContainer. "<- take random element"
	aContainer size: 500@400.
	aContainer addEventHandler: BlSelectionHandler new. "<- add selection handler"

	aSpace := BlSpace new.
	aSpace root addChild: aContainer.

	aSpace root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	aSpace show