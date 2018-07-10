testing
isRoot
	"Return true if I am a root element of a space, false otherwise"
	<return: #Boolean>

	^ self isAttachedToSceneGraph and: [ self space root = self ]