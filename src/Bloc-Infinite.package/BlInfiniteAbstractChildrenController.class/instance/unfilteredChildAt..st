element -> manager
unfilteredChildAt: anIndex
	"Return a child within infinite element
	or nil if anIndex is outside of the range"
	<return: #BlElement or: nil>
	
	^ self subclassResponsibility