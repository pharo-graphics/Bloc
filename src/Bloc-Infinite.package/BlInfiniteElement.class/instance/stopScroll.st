scrolling
stopScroll
	"Stop any current scroll in progress, such as one started by
		- #smoothScrollBy:
		- #fling:
		- or a touch-initiated fling"

	self scrollState: ScrollIdle.
	self stopScrollersInternal