shape examples
exampleWithImage
	| space |
	space := BlSpace new
		extent: 600 @ 450;
		title: 'Image example'.

	space root
		addChild: (
		((BlRectangle extent: 300@200) cornerRadius: 40) asElement
		background: (BlImagePatternPaint form: PolymorphSystemSettings pharoLogoForm);
		position: 100 @ 100);
		yourself.

	space root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	
	space show