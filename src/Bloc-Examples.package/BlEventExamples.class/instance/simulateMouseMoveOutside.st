events - simulation
simulateMouseMoveOutside
	<gtExample>
	| element mouseLeave mouseMove mouseEnter |
	
	element := self blueElement.
	element size: 100@100.
	element relocate: 100@100.
	
	mouseLeave := mouseMove := mouseEnter := 0.
	
	element addEventHandlerOn: BlMouseMoveEvent do: [ mouseMove := mouseMove + 1 ].
	element addEventHandlerOn: BlMouseEnterEvent do: [ mouseEnter := mouseEnter + 1 ].
	element addEventHandlerOn: BlMouseLeaveEvent do: [ mouseLeave := mouseLeave + 1 ].
	
	BlSpace simulateMouseMoveOutside: element.

	self assert: mouseMove equals: 0.
	self assert: mouseEnter equals: 0.
	self assert: mouseLeave equals: 0.
	
	^ element