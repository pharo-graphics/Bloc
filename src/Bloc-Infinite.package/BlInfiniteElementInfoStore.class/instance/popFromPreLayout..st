adding/removing
popFromPreLayout: anElementHolder
	"Finds the ItemHolderInfo for the given element holder in preLayout list and removes it"
	<return: #BlInfiniteItemInfoHolder or: nil>

	^ self
		popFromLayoutStep: anElementHolder
		flag: BlInfiniteInfoStoreRecordFlags Pre