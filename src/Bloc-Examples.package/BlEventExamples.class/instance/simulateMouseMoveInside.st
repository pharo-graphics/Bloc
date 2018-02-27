events - simulation
simulateMouseMoveInside
	<gtExample>
	| element mouseMove mouseEnter |
	
	element := self blueElement.
	element size: 100@100.
	element relocate: 100@100.
	
	mouseMove := mouseEnter := 0.
	
	element addEventHandlerOn: BlMouseMoveEvent do: [ mouseMove := mouseMove + 1 ].
	element addEventHandlerOn: BlMouseEnterEvent do: [ mouseEnter := mouseEnter + 1 ].
	
	BlSpace simulateMouseMoveInside: element.

	self assert: mouseMove equals: 1.
	self assert: mouseEnter equals: 1.
	
	^ element