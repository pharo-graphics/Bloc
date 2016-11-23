children add/remove
addDisappearingChild: anElement
	"To be used only during #layoutChildren to add an element to the layout that is known to be going away,
	either because it has been removed or because it is actually not in the visible portion of the container
	but is being laid out in order to inform infinite element in how to animate the item out of view."

	self addDisappearingChild: anElement at: 0