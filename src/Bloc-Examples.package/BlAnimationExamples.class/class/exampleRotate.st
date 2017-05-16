examples
exampleRotate
	<example>
	| sp el a2 |
	sp := BlSpace new.
	el := BlElement new
		background: (BlBackground fill: Color blue);
		size: 100 @ 200;
		position: 300 @ 100.
	
	a2 := BlRotateAnimation new
		easing: BlEasing bounceOut;
		angle:180;
		duration: 2000;
		delay:2000;
		loop:2;
		target: el.
	
	sp root addChild: el.
	sp show.
	a2 start