renderer - testing
renderNeeded
	"Return true if I need to render a scene according to my
	current configuration. By default I check if there are
	any dirty areas, if there are none - no need to render"
	<return: #Boolean>
	
	^ self dirtyAreas notEmpty