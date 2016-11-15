element -> manager
findHiddenNonRemovedChildAt: aPosition type: anItemType
	"Find and return a disappearing child by its adapter position
	or nil if no such child was found"
	<return: #BlElement or: nil>
	
	^ self shouldBeImplemented