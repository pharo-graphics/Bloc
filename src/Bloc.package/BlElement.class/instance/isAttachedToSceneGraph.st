children testing
isAttachedToSceneGraph
	"Return true if I am inside of a scene graph, e.g. I have a space's root element
	as my top-most parent, false otherwise"
	<return: #Boolean>

	"To support temporary detachment/attachment which sets parent to nil but
	preserves reference to space we can not recursively go up in parent's hierarchy
	and have to check space reference existence instead"
	^ self space isNotNil and: [
		self space hostSpace isNotNil ]