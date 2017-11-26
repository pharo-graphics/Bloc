instance creation - hand
handDot
	<gtExample>

	^ BlElement new
		background: Color red;
		size: 15@15;
		geometry: BlEllipse new;
		constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignRight ];
		yourself