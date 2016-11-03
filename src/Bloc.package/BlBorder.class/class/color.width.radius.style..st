instance creation
color: aColor width: aWidth radius: aRNumber style: aBorderStrokeStyle
	^ self
		stroke:
			(BlBorderStroke
				color: aColor
				width: aWidth
				radius: aRNumber
				style: aBorderStrokeStyle)