examples
layoutChanged
	<gtExample>
	| layoutChanged element |
	layoutChanged := 0.
	
	element := self child.
	element addEventHandlerOn: BlElementLayoutChangedEvent do: [ layoutChanged := layoutChanged + 1 ].

	element layout: BlLinearLayout vertical.
	self assert: layoutChanged equals: 1.

	^ element