instance creation
circleAttachPoint
	<gtExample>	

	^ BlElement new
		geometry: BlEllipse new;
		size: 75@75;
		background: (Color blue alpha: 0.3);
		border: BlBorder empty;
		addEventHandler: BlPullHandler new