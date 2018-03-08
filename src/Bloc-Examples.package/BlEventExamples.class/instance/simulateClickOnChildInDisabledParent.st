events - simulation
simulateClickOnChildInDisabledParent
	<gtExample>
	| parent red mouseDown mouseUp click |
	
	parent := self grayElement.
	parent size: 300@300.
	"make parent element be unresponsive to mouse events"
	parent preventMouseEvents.
	
	red := self redElement.
	red size: 200@200.
	red opacity: 0.2.

	parent addChildren: { red }.

	mouseDown := mouseUp := click := 0.
	
	red addEventHandlerOn: BlMouseDownEvent do: [ mouseDown := mouseDown + 1 ].
	red addEventHandlerOn: BlMouseUpEvent do: [ mouseUp := mouseUp + 1 ].
	red addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].
	
	BlSpace simulateClickOn: red.
	
	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1.
	
	^ parent