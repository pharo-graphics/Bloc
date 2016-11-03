examples
exampleSequential
	<example> 
	| sp el a1 a2 cAnim |
	sp := BlSpace new.
	el := BlElement new
		background: (BlBackground fill: Color blue);
		extent: 100 @ 100;
		position: 100 @ 100.
	a1 := BlTranslateAnimation new
		easing: BlEasing bounceOut;
		to: 300 @ 300;
		duration: 2000;
		target: el.
	a2 := BlScaleAnimation new
		target: el;
		easing: BlEasing bounceOut;
		scaleTo: 2@2;
		duration: 2000.
	cAnim := BlSequentialAnimation new
		addAll: {a1. a2}.
	sp root addChild: el.
	sp show.
	cAnim start