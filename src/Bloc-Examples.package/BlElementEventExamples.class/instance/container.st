instance creation
container
	<gtExample>

	^ BlElement new
		size: 500@400;
		border: (BlBorder builder dashed width: 2; paint: Color red; build)