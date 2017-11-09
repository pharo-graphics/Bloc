examples
bouncingChicken
	<gtExample>
	| element animation |
	element := BlChicken chicken.
	element relocate: 140@40.
	element transform
		scaleBy: 0.1@0.1;
		translateBy: (100@300) negated;
		rotateBy: -30;
		apply.
	animation := BlTransformAnimation new.
	animation transform
		scaleBy: 1@1;
		translateBy: 0@0;
		rotateBy: 0;
		apply.
	animation absolute.
	animation duration: 4 seconds.
	animation easing: BlEasing bounceIn.
	animation startOn: element.
	^ element