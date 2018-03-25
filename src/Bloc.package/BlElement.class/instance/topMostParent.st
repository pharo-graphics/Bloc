children accessing
topMostParent
	"Return a topmot parent in a scene graph.
	A topmost parent is an element that does not have a parent by its own"
	<return: #BlElement>

	^ self hasParent
		ifTrue: [ self parent topMostParent ]
		ifFalse: [ self ]