initialize-release
initialize
	super initialize.
	lastEnteredTargets := OrderedCollection new.
	isMouseStillDown := 0.
	dragStartMask := 0.
	dndInProgress := false.

	"a set of currently pressed mouse buttons button"
	pressedButtons := Set new.
	dragState := BlMouseDragState new