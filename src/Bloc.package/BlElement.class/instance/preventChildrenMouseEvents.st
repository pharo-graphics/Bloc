event handling
preventChildrenMouseEvents
	"Prevent me *and* my children from receiving mouse events"

	self addEventFilterOn: BlMouseEvent do: [ :anEvent | anEvent consumed: true ]