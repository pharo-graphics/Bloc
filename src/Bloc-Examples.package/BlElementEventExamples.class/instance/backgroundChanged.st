examples
backgroundChanged
	<gtExample>
	| backgroundChanged element |
	backgroundChanged := 0.
	
	element := self child.
	element addEventHandlerOn: BlElementBackgroundChangedEvent do: [ backgroundChanged := backgroundChanged + 1 ].

	element background: Color blue.
	self assert: backgroundChanged equals: 1.
	
	^ element