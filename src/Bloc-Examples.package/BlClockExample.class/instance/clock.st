instance creation - clock
clock
	<gtExample>

	^ BlElement new
		geometry: BlEllipse new;
		border: (BlBorder builder width: 1; paint: Color black; build);
		layout: BlFrameLayout new;
		size: self radius asPoint * 2