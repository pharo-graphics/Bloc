examples
exampleColors
	| space element |
	space := BlSpace new
		extent: 800 @ 650;
		title: 'Infinite list example'.
	element := BlInfiniteExampleColorsListElement new
		extent: 300 @ 500;
		constraintsDo: [ :c | c padding: (BlInsets all: 20) ];
		background: Color gray;
		yourself.
	space root addChild: element.
	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show