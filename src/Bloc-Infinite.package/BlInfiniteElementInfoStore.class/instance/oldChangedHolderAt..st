accessing
oldChangedHolderAt: aKey
	"Queries the oldChangeHolder list for the given key. If they are not tracked, simply returns nil"
	<return: #BlInfiniteHolder or: nil>

	^ oldChangedHolders at: aKey ifAbsent: [ nil ]