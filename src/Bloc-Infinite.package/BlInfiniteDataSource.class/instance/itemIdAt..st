accessing
itemIdAt: aPosition
	"Return the stable ID for the item at aPosition.
	If #hasStableIds would return false this method should return ===BlInfiniteElement noId===.
	The default implementation of this method returns ===BlInfiniteElement noId==="
	<return: #Number>

	^ BlInfiniteElement noId