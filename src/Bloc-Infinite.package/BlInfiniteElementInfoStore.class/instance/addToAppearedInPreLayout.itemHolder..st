adding/removing
addToAppearedInPreLayout: anElementHolder itemHolder: anItemHolder
	"Adds the given ElementHolder to the appeared in pre layout list. These are Elements added by the
	InfiniteLayout during a pre-layout pass. We distinguish them from other elements that were
	already in the pre-layout so that ItemAnimator can choose to run a different animation for them"
	| aRecord |
	
	aRecord := layoutHolderMap
		at: anElementHolder
		ifAbsentPut: [ BlInfiniteElementInfoStoreRecord obtain ].
	
	aRecord flags addAppear.
	aRecord preInfo: anItemHolder