instance creation
parent
	<gtExample>

	^ BlElement new
		layout: BlFrameLayout new;
		border: (BlBorder builder dashed; paint: Color red; width: 3; build);
		yourself