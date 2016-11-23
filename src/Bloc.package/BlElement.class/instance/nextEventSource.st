event management accessing
nextEventSource
	"Return next object that should be contained in dispatch chain or nil if none.
	Note: returned object must use TBlEventSupporter!"
	<return: #TBlEventSource or: nil>

	^ self parent