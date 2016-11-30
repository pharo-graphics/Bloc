adding/removing
addToPreLayout: anElementHolder itemHolder: anItemHolder
	"Adds the item information to the pre layout tracking"
	| aRecord |
	
	aRecord := layoutHolderMap
		at: anElementHolder
		ifAbsentPut: [ BlInfiniteElementInfoStoreRecord obtain ].
	
	aRecord flags addPre.
	aRecord preInfo: anItemHolder