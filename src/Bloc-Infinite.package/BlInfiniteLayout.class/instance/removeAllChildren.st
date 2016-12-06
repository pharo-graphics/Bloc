children - add/remove
removeAllChildren
	"Remove all elements from the currently attached infinite element.
	This will not recycle any of the affected element; the InfiniteLayout is responsible for doing so if desired."

	"Only remove non-animating elements"
	self reverseChildrenDo: [ :anElement :anIndex |
		childManager removeChildAt: anIndex ]