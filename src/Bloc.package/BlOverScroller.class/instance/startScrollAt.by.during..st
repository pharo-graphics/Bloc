api - scrolling
startScrollAt: aStartPoint by: aDeltaPoint during: aDuration
	
	mode := Scroll.
	scrollerX
		startScrollBy: aDeltaPoint x
		from: aStartPoint x
		during: aDuration
		interpolator: interpolator.

	scrollerY
		startScrollBy: aDeltaPoint y
		from: aStartPoint y
		during: aDuration
		interpolator: interpolator