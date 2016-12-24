testing
isTransparent
	"Return true if I am is transparent and should not be rendered,
	false otherwise"
	<return: #Boolean>

	^ width isZero or: [ paint isTransparent ]