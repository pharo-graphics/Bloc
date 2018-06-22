iterator - testing
isLineDelimiter: anItem
	"Return true of given item represents a line delimiter symbol, false otherwise"
	<return: #Boolean>

	^ (self isCarriageReturn: anItem) or: [ self isLineFeed: anItem ]