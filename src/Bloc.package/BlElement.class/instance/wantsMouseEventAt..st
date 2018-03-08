event handling
wantsMouseEventAt: aPoint
	"Return true if I can be picked as target for mouse event at given location specified in space coordinates.
	By default elements can handle mouse events if they are visible and not transparent for mouse events"
	<return: #Boolean>

	^ self isVisible and: [
		self shouldHandleMouseEvents and: [
			self containsGlobalPoint: aPoint ] ]