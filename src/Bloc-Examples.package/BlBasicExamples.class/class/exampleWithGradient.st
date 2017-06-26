shape examples
exampleWithGradient
	| space |
	space := BlSpace new
		extent: 600 @ 450;
		title: 'Gradient example'.

	space root
		addChild: (
		((BlRectangle extent: 300@200) cornerRadius: 40) asElement
		background: (BlLinearGradientPaint new
		stops:
			{(0.0 -> Color white).
			(0.5 -> Color gray).
			(1.0 -> Color veryDarkGray)};
		start: 0@0;
		end: 300@200;
		yourself);
		position: 100 @ 100);
		yourself.

	space root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	
	space show