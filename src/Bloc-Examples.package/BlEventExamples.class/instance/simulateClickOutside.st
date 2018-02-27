events - simulation
simulateClickOutside
	<gtExample>
	| element mouseDown mouseUp click |
	
	element := self blueElement.
	element size: 100@100.
	element relocate: 100@100.
	
	mouseDown := mouseUp := click := 0.
	
	element addEventHandlerOn: BlMouseDownEvent do: [ mouseDown := mouseDown + 1 ].
	element addEventHandlerOn: BlMouseUpEvent do: [ mouseUp := mouseUp + 1 ].
	element addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].
	
	BlSpace simulateClickOutside: element.
	
	self assert: mouseDown equals: 0.
	self assert: mouseUp equals: 0.
	self assert: click equals: 0.
	
	^ element