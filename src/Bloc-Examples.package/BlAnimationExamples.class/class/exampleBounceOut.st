examples
exampleBounceOut
	<example>
	| sp el anim |
	sp := BlSpace new.
	el := BlElement new
		background: Color blue;
		position: 100 @ 100.
	anim := BlTranslateAnimation new
		easing: BlEasing bounceOut;
		to: 0 @ 400;
		duration: 1000;
		target: el. 
	el
		addEventHandler:
			(BlOnClickHandler
				do: [ el position: 100 @ 100.
					anim start ]).
	sp root addChild: el.
	sp show