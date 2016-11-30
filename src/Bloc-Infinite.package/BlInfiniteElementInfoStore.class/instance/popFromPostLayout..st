adding/removing
popFromPostLayout: anElementHolder
	"Finds the ItemHolderInfo for the given element holder in postLayout list and removes it"
	<return: #BlInfiniteItemInfoHolder or: nil>

	^ self
		popFromLayoutStep: anElementHolder
		flag: BlInfiniteInfoStoreRecordFlags Post