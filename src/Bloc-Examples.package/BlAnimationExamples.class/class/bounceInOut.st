instance creation
bounceInOut
	<gtExample>
	
	^ BlTranslateAnimation new
		easing: BlEasing bounceInOut;
		to: 300 @ 300;
		duration: 2000;
		yourself