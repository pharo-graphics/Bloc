debug - simulation
simulateMouseMoveInside: anElement
	"Simulate a mouse move event at a random location within element's bounds"
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace bounds atRandom.

	self
		simulateEvents: { BlMouseMoveEvent primary position: aPosition }
		on: anElement