event management accessing
nextEventTarget
	"Return next object that should be contained in dispatch chain or nil if none.
	Note: returned object must use TBlEventTarget!"
	<return: #TBlEventTarget or: nil>

	^ self parent