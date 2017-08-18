children accessing
hasParent
	"Return true if I have a parent, otherwise false.
	Being added as direct child to other element does not necessary
	mean that I am in the space scene graph"
	<return: #Boolean>

	^ self parent isNotNil