examples
sequential
	<script: 'self sequential'>
	| space element translation scale sequential |
	
	translation := (BlTransformAnimation translate: 300 @ 300)
		easing: BlEasing bounceOut;
		duration: 2 seconds.

	scale := (BlTransformAnimation scale: 2 @ 2)
		easing: BlEasing bounceOut;
		duration: 2 seconds.

	sequential := BlSequentialAnimation new addAll: { translation. scale }.
	
	element := BlElement new
		background: (BlBackground paint: Color blue);
		size: 100 @ 100;
		relocate: 100 @ 100.	
	element addAnimation: sequential.
	
	space := BlSpace new.
	space root addChild: element.
	space show