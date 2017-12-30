examples
removedFromParent
	<gtExample>
	| wasRemoved parent child container |
	
	wasRemoved := 0.
	
	child := self child.
	child addEventHandlerOn: BlElementRemovedEvent do: [ wasRemoved := wasRemoved + 1 ].
	
	parent := self parent.
	container := self container.

	parent addChild: child.
	container addChild: parent.
	
	container removeChild: parent.
	parent removeChild: child.
	
	self assert: wasRemoved equals: 1.
	^ container