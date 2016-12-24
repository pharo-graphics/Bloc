testing
isTransparent
	"Return true if border is transparent and should not be rendered,
	false otherwise"
	<return: #Boolean>

	^ image isNil and: [ stroke isTransparent ]