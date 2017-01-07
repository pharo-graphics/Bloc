testing
isSubAnimation
	"Return true if I am a sub animation, e.g. added to composite animation,
	false otherwise"
	<return: #Boolean>

	^ self parent isNotNil