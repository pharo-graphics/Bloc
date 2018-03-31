private - accessing
infiniteElement
	"Return an infinite element a child of which a hold.
	infiniteElement may be nil if I am not attached, for example if
	I am recycled or removed"
	<return: #BlInfiniteElement>

	^ infiniteElement