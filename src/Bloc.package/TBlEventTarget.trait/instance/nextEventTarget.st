event management accessing
nextEventTarget
	"Return next event source that should be contained in dispatch chain or nil if none.
	Note: returned object must use TBlEventSource!"
	<return: #TBlEventTarget or: nil>

	^ self explicitRequirement