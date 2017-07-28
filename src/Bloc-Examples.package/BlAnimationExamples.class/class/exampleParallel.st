examples
exampleParallel
	<example>
	| sp el a1 a2 cAnim |
	sp := BlSpace new.
	el := BlElement new
		background: (BlBackground paint: Color blue);
		extent: 100 @ 100;
		position: 100 @ 100.
	a1 := BlTranslateAnimation new
		easing: BlEasing bounceOut;
		to: 300 @ 300;
		duration: 2000;
		target: el. 
	a2 := BlScaleAnimation new
		easing: BlEasing bounceOut;
		scaleToX: 2;
		scaleToY: 2;
		duration: 2000;
		target: el.
	cAnim := BlParallelAnimation new
		add: a1;
		add: a2.
	sp root addChild: el.
	sp show.
	cAnim start