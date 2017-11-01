instance creation
rotation
	"<gtExample>"

	^ BlRotateAnimation new
		easing: BlEasing bounceOut;
		angle: 180;
		duration: 1000;
		delay: 1000;
		loop: 2;
		yourself