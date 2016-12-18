adding/removing
addToDisappearedInLayout: anElementHolder
	"An ElementHolder might be added by the InfiniteLayout just to animate its disappearance.
	This list holds such items so that we can animate / recycle these ElementHolders properly."
	| aRecord |

	aRecord := layoutHolderMap
		at: anElementHolder
		ifAbsentPut: [ BlInfiniteElementInfoStoreRecord obtain ].

	aRecord flags addDisappeared