testing
isHorizontal
	"Return true if this event has a horizontal scrolling component"
	<return: #Boolean>
	
	^ self isScrollLeft or: [ self isScrollRight ]