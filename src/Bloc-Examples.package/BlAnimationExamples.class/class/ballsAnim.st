examples
ballsAnim
	<script: 'self ballsAnim'>
|space els anims|
anims := OrderedCollection new.
els := OrderedCollection new.

	(1 to:100) do: [:i| |el tr alp ii| 
		ii := i % 25.
		el :=(BlEllipse diameter: 30) asElement 
		background: (Color white alpha: 0);
		relocate: (ii*15)@10.
			
		tr := BlTransformAnimation new
			target: el;
			transformDo: [ :aBuilder | aBuilder translateBy: (ii*15) @(500 -(30*((i/25)ceiling) )) ];
			delay: 80 milliSeconds * i;
			duration: 500 milliSeconds;
			easing: BlEasing bounceOut.
			
		alp := BlColorTransition new
					from: (Color white alpha: 0);
					to: Color random;
					delay: 80 milliSeconds * i;
					duration: 100 milliSeconds;
					onStepDo: [ :c | el background: c].
		anims addAll: {tr.alp}.els add: el.
		].

	space := BlSpace new.
	space root addChildren: els.
	space show.
		
	BlParallelAnimation new
		addAll: anims;
	 	start