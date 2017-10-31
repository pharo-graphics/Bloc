events - simulation
simulateClick
	<gtExample>
	| element mouseDown mouseUp click |
	
	element := self blueElement.
	element size: 100@100.
	element relocate: 0@0.
	
	mouseDown := mouseUp := click := 0.
	
	element addEventHandlerOn: BlMouseDownEvent do: [ mouseDown := mouseDown + 1 ].
	element addEventHandlerOn: BlMouseUpEvent do: [ mouseUp := mouseUp + 1 ].
	element addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].
	
	BlSpace simulateClickOn: element.
	
	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1.
	
	^ element