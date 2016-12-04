accessing
itemTypeAt: aPosition
	"Return the element type of the item at aPosition for the purposes of element recycling.
	The default implementation of this method returns ===BlInfiniteItemType invalid===,
	making the assumption of a single element type for the data source."
	<return: #BlInfiniteItemType>

	^ BlInfiniteItemType invalid