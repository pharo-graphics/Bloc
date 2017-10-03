tests
positionChangeLoop
	<gtExample>
	| element positionChanged positionChangedListener positionInSpaceChanged positionInSpaceChangedListener |
	
	element := self element.
	positionChanged := 0.
	positionInSpaceChanged := 0.

	positionChangedListener := BlEventHandler
		on: BlElementPositionChangedEvent
		do: [ positionChanged := positionChanged + 1 ].
	positionInSpaceChangedListener := BlEventHandler
		on: BlElementPositionInSpaceChangedEvent
		do: [ positionInSpaceChanged := positionInSpaceChanged + 1 ].
	
	element addEventHandler: positionChangedListener.
	element addEventHandler: positionInSpaceChangedListener.
	
	element position: 30@30 extent: element extent.
	element commitChanges.
	
	self assert: positionChanged equals: 1.
	self assert: positionInSpaceChanged equals: 1.
	
	positionChanged := 0.
	positionInSpaceChanged := 0.
	
	element position: 40@40 extent: element extent.
	element position: 30@30 extent: element extent.
	element commitChanges.
	
	self assert: positionChanged equals: 0.
	self assert: positionInSpaceChanged equals: 0.

	^ element