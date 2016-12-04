hooks
onElementRecycled: anElementHolder
	"Sent when an element created by this datasource has been recycled.
	An element is recycled when an InfiniteLayout decides that it no longer
	needs to be attached to InfiniteElement. This can be because it has
	fallen out of visibility or a set of cached elements represented by elements still
	attached to the parent InfiniteElement. If an item element has large or expensive data
	bound to it such as large bitmaps, this may be a good place to release those resources"