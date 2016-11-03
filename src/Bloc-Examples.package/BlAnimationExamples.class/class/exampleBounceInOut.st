examples
exampleBounceInOut
	<example>
	| sp el anim |
	sp := BlSpace new.
	el := BlText new
		text: 'click me';
		position: 100 @ 100.
	anim := BlTranslateAnimation new
		easing: BlEasing bounceInOut;
		to: 300 @ 300;
		duration: 2000;
		target: el.
	el
		addEventHandler:
			(BlOnClickHandler
				do: [ el position: 100 @ 100.
					anim start ]).
	sp root addChild: el.
	sp show