testing
isStyle
	"Return true if attribute represents a text or font style attribute that only changes how text looks,
	for example foreground, background, weight, emphasis etc.
	By default all attributes are treated as style ones. Action attributes should return false"
	<return: #Boolean>

	^ true