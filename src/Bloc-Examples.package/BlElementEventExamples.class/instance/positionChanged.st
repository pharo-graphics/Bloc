examples
positionChanged
	<gtExample>
	| positionChanged parent child |
	
	positionChanged := 0.
	
	child := self child.
	parent := self parent.
	parent addChild: child.
	parent forceLayout.
	
	child addEventHandlerOn: BlElementPositionChangedEvent do: [ positionChanged := positionChanged + 1 ].
	
	child relocate: child position + (20@20).
	child forceLayout.
	self assert: positionChanged equals: 1.

	"relocating child to the same position should not trigger an event"
	child relocate: child position.
	child forceLayout.
	self assert: positionChanged equals: 1.

	^ parent