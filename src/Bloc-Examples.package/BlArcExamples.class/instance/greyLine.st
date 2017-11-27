example - visual properties
greyLine
	<gtExample>

	^ self line
		border: (BlBorder builder paint: (Color gray alpha: 0.5); width: 1; build)