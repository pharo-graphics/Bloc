events - simulation
simulateClickOnOverlapped
	"I simulate a click on the element which is overlapped by another element.
	Since element above does not consume click events, one below should succesfully
	handle mouse down/up and click events"
	
	"<gtExample>" "<- fails becaus we need 'elevation based' event handling (Bloc-Compositor)"
	| container blue red mouseDown mouseUp click |
	
	container := self grayElement.
	container size: 300@300.
	
	red := self redElement.
	red size: 200@200.
	red opacity: 0.2.
	
	"blue is below the red element"
	blue := self blueElement.
	blue size: 100@100.
	blue opacity: 0.2.
	
	container addChildren: { blue . red }.
	
	mouseDown := mouseUp := click := 0.
	
	blue addEventHandlerOn: BlMouseDownEvent do: [ mouseDown := mouseDown + 1 ].
	blue addEventHandlerOn: BlMouseUpEvent do: [ mouseUp := mouseUp + 1 ].
	blue addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].
	
	BlSpace simulateClickOn: blue.
	
	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1.
	
	^ container