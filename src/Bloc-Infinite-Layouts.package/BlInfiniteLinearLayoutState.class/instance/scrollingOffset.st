accessing
scrollingOffset
	"Return the amount of scrolling we can make without creating a new element.
	Taking me into account allows us to have efficient element recycling"
	<return: #Number>

	^ scrollingOffset