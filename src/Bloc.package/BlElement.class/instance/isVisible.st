testing
isVisible
	"Return true if I should be visible, false otherwise.
	Note, that I am not the same as isTransparent/isOpaque, those
	just influence rendering and not behaviour or interraction.
	If element is invisible it does not receive events such as mouse clicks"
	<return: #Boolean>

	^ self visibility isVisible