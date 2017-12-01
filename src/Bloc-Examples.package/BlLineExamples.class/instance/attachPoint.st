instance creation
attachPoint
	<gtExample>	

	^ BlElement new
		geometry: BlEllipse new;
		size: 30@30;
		background: (Color blue alpha: 0.3);
		border: BlBorder empty;
		addEventHandler: BlDragHandler new