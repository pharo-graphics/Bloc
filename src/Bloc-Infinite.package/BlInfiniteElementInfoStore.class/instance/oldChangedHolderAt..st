accessing
oldChangedHolderAt: aKey
	"Queries the oldChangeHolder list for the given key. If they are not tracked, simply returns nil"
	<return: #BlInfiniteElementHolder or: nil>

	^ oldChangedHolders at: aKey ifAbsent: [ nil ]