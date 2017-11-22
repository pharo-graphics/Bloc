accessing
itemTypeAt: aPosition
	"All my items are homogene, it is enough to use a named item type"
	<return: #BlInfiniteItemType>

	^ BlInfiniteNamedItemType named: #class