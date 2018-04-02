instance creation
jiggleAnimation
	| anAnimation |
	<gtExample>
	
	anAnimation := BlTransformAnimation new.
	anAnimation transform
		translateBy: 0 @ (50 + 20 atRandom) negated;
		rotateBy: (30 atRandom - 15);
		scaleBy: (1.3 + (20 atRandom / 100.0))@(1.3 + (20 atRandom / 100.0));
		apply.
	anAnimation absolute.
	anAnimation easing: (BlSineInterpolator new range: Float pi).	
	anAnimation loops: 3.
	anAnimation duration: 1 second.
	
	^ anAnimation