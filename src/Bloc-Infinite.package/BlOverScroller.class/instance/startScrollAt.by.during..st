scrolling
startScrollAt: aStartPoint by: aDeltaPoint during: aDuration

	mode := Scroll.
	scrollerX startScrollBy: aDeltaPoint x from: aStartPoint x during: aDuration.
	scrollerY startScrollBy: aDeltaPoint y from: aStartPoint y during: aDuration