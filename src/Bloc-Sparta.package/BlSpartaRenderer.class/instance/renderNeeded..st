renderer - testing
renderNeeded: aSpace
	"Return true if I need to render a given space.
	By default I check if there are any dirty areas, if there are none - no need to render"
	<return: #Boolean>

	^ aSpace dirtyAreas notEmpty