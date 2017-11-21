instance creation
cell
	<gtExample>
	
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal exact: 50.
			c vertical exact: 25.
			c margin: (BlInsets top: 10 right: 0 bottom: 0 left: 10) ];
		yourself