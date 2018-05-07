examples - instance creation
contentElement
	<gtExample>

	^ BlElement new
		background: ((BlLinearGradientPaint direction: 1@1) stops: {
			0 -> Color blue.
			1 -> Color red
		})