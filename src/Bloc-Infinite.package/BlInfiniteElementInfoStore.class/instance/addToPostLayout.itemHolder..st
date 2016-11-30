adding/removing
addToPostLayout: anElementHolder itemHolder: anItemHolder
	"Adds the item information to the post layout tracking"
	| aRecord |

	aRecord := layoutHolderMap
		at: anElementHolder
		ifAbsentPut: [ BlInfiniteElementInfoStoreRecord obtain ].

	aRecord flags addPost.
	aRecord postInfo: anItemHolder