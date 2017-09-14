instance creation
matchParent
	<gtExample>

	^ BlElement new
		background: Color indexedColors atRandom;
		border: (BlBorder builder paint: Color blue; width: 1; build);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ];
		yourself