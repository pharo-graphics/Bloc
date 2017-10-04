example
example
	<gtExample>
	| yellow green red container |
	
	yellow := self yellow
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	green := self green
		size: 200@200;
		constraintsDo: [ :c |
			c frame horizontal alignRight.
			c frame vertical alignBottom ].
	
	red := self red
		size: 100@100;
		constraintsDo: [ :c|
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].

	container := self container
		layout: BlFrameLayout new;
		size: 350@350;
		relocate: 200@100;
		addChildren: { yellow . green . red }.
	
	^ container
	