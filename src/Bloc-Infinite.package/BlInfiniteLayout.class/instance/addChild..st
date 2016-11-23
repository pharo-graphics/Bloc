children add/remove
addChild: anElement
	"Add an element to the currently attached infinite element if needed.
	Infinite Layouts should use me to add elements obtained from a Recycler using Recycler>>#elementFor:"

	self addChild: anElement at: 0