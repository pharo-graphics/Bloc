instance creation
gridCell
	<gtExample>
	
	^ BlTextElement new
		addEventHandler: BlPullHandler new;
		background: Color veryLightGray;
		padding: (BlInsets all: 10);
		constraintsDo: [ :c |
			c grid horizontal alignCenter.
			c grid vertical alignCenter ];
		yourself