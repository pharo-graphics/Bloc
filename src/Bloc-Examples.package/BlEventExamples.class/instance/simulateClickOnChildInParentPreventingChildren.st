events - simulation
simulateClickOnChildInParentPreventingChildren
	<gtExample>
	| parent red childMouseDown childMouseUp childClick parentMouseDown parentMouseUp parentClick |
	
	parent := self grayElement.
	parent size: 300@300.
	"make parent element and children be unresponsive to mouse events"
	parent preventChildrenMouseEvents.
	
	red := self redElement.
	red size: 200@200.
	red opacity: 0.2.

	parent addChildren: { red }.

	childMouseDown := childMouseUp := childClick := 0.
	red addEventHandlerOn: BlMouseDownEvent do: [ childMouseDown := childMouseDown + 1 ].
	red addEventHandlerOn: BlMouseUpEvent do: [ childMouseUp := childMouseUp + 1 ].
	red addEventHandlerOn: BlClickEvent do: [ childClick := childClick + 1 ].
	
	parentMouseDown := parentMouseUp := parentClick := 0.
	parent addEventHandlerOn: BlMouseDownEvent do: [ parentMouseDown := parentMouseDown + 1 ].
	parent addEventHandlerOn: BlMouseUpEvent do: [ parentMouseUp := parentMouseUp + 1 ].
	parent addEventHandlerOn: BlClickEvent do: [ parentClick := parentClick + 1 ].
	
	BlSpace simulateClickOn: red.
	
	self assert: childMouseDown equals: 0.
	self assert: childMouseUp equals: 0.
	self assert: childClick equals: 0.
	
	self assert: parentMouseDown equals: 1.
	self assert: parentMouseUp equals: 1.
	self assert: parentClick equals: 1.
	
	^ parent