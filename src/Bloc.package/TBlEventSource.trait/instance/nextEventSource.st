event management accessing
nextEventSource
	"Return next event source that should be contained in dispatch chain or nil if none.
	Note: returned object must use TBlEventSource!"
	<return: #TBlEventSource or: nil>

	^ self explicitRequirement