examples
sequential
	<script: 'self sequential'>
	| space element translation scale sequential |
	
	element := BlElement new
		background: (BlBackground paint: Color blue);
		size: 100 @ 100;
		relocate: 100 @ 100.	
			
	translation := (BlTransformAnimation translate: 300 @ 300)
		easing: BlEasing bounceOut;
		duration: 2 seconds;
		target: element.

	scale := (BlTransformAnimation scale: 2 @ 2)
		easing: BlEasing bounceOut;
		duration: 2 seconds;
		target: element.
		
	sequential := BlSequentialAnimation new addAll: { translation. scale }.
	
	space := BlSpace new.
	space root addChild: element.
	space show.
	
	sequential start