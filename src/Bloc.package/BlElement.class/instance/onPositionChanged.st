hooks - geometry
onPositionChanged
	"Is sent when my position changed within a parent"
	
	self invalidateInParent.
	self notifyPositionChanged