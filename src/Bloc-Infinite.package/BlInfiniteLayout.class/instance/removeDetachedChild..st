children add/remove
removeDetachedChild: anElement
	"Finish removing a child element that was previously temporarily detached"

	infiniteElement removeDetachedChild: anElement animate: false