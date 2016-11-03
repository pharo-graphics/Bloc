examples
exampleBallsAnim
|space els anims|
anims := OrderedCollection new.
els := OrderedCollection new.

	(1 to:100) do: [:i| |el tr alp ii| 
		ii := i % 25.
		el :=(BlEllipse diameter: 30) asElement 
		background: (Color random alpha: 1);
		position: (ii*30)@100.
		tr := BlTranslateAnimation new
			target: el;
			to: el position x @(500 -(30*((i/25)ceiling) ));
			delay: i*50;duration: 300;
			easing: BlEasing bounceOut.
		alp := BlColorTransition new
					from: (Color white alpha: 0);
					to: Color random;
					delay: i*10;duration: 100;
					onStepDo:[:c| el background: c].
		anims addAll: {tr}.els add: el.
		].

	space := BlSpace new.
	space root addChildren: els.
	space show.
		
	BlParallelAnimation new
		addAll: anims;
	 	start