examples
borderChanged
	<gtExample>
	| borderChanged element |
	borderChanged := 0.
	
	element := self child.
	element addEventHandlerOn: BlElementBorderChangedEvent do: [ borderChanged := borderChanged + 1 ].

	element border: (BlBorder builder paint: Color gray; width: 5; build).
	self assert: borderChanged equals: 1.
	
	^ element