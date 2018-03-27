examples
addedToParent
	<gtExample>
	| wasAdded parent child container |
	
	wasAdded := 0.
	
	child := self child.
	child addEventHandlerOn: BlElementAddedToParentEvent do: [ wasAdded := wasAdded + 1 ].
	
	parent := self parent.
	container := self container.
	
	"is sent only when child is added to the parent"
	parent addChild: child.
	"will not be sent when adding parent to a container"
	container addChild: parent.
	
	self assert: wasAdded equals: 1.
	^ container