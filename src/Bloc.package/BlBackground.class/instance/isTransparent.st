testing
isTransparent
	"Return true if background is transparent and should not be rendered, false otherwise"
	<return: #Boolean>

	^ image isNil and: [ fill isTransparent ]