instance creation
jiggleAnimation
	| anAnimation |
	<gtExample>
	
	anAnimation := BlTransformAnimation new.
	anAnimation transform
		translateBy: 0 @ (50 + 20 atRandom);
		rotateBy: (30 atRandom - 15);
		scaleBy: (1.3 + (20 atRandom / 100.0))@(1.3 + (20 atRandom / 100.0));
		apply.
	anAnimation absolute.
	anAnimation easing: BlSinusInterpolator default.	
	anAnimation loop: 5.
	anAnimation duration: 1 second.
	
	^ anAnimation