scrolling
scrollToPosition: aPositionInDataSource
	"Scroll the InfiniteELement to make the datasource position visible.
	Note: scroll position change will not be reflected until the next layout cycle (space pulse)"
	
	pendingScrollPosition := aPositionInDataSource.
	pendingScrollPositionOffset := self class invalidOffset.

	self requestLayout