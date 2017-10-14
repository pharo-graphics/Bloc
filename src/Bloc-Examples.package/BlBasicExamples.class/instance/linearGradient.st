examples - background
linearGradient
	<gtExample>
	
	^ BlLinearGradientPaint new
		stops: {
			(0.0 -> Color white).
			(0.5 -> Color gray).
			(1.0 -> Color veryDarkGray)
		};
		start: 0@0;
		end: 300@200;
		yourself