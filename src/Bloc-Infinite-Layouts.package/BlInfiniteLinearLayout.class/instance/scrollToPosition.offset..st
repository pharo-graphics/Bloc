scrolling
scrollToPosition: aPositionInDataSource offset: anOffset
	"Scroll the InfiniteELement to make the datasource position visible with the given offset from resolved layout start.
	For example, if layout is ===vertical=== and ===stackFromEnd=== is true,
	sending ===scrollToPosition: 10 offset: 20=== will layout such that 10th item's
	bottom is 20 pixels above the InfiniteElement's bottom.
	Note: scroll position change will not be reflected until the next layout cycle (space pulse)"
	
	pendingScrollPosition := aPositionInDataSource.
	pendingScrollPositionOffset := anOffset.

	self requestLayout