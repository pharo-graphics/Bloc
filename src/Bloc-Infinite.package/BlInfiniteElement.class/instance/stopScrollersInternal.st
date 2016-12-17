private - scrolling
stopScrollersInternal
	"Similar to #stopScroll but does not set the state"

	scrollFlinger stop.
	self layout stopSmoothScroller