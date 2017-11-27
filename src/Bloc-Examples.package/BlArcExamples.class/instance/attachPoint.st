instance creation
attachPoint
	<gtExample>	

	^ BlAttachPointExample new
		size: 30@30;
		background: (Color blue alpha: 0.3);
		border: BlBorder empty;
		addEventHandler: BlDragHandler new