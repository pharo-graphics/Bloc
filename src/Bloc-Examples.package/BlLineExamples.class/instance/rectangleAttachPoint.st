instance creation
rectangleAttachPoint
	<gtExample>	

	^ BlElement new
		size: 75@75;
		background: (Color blue alpha: 0.3);
		border: BlBorder empty;
		addEventHandler: BlPullHandler new