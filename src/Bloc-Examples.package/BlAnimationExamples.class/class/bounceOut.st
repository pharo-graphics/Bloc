instance creation
bounceOut
	"<gtExample>"
	
	^ BlTranslateAnimation new
		easing: BlEasing bounceOut;
		to: 0 @ 400;
		duration: 1000;
		yourself