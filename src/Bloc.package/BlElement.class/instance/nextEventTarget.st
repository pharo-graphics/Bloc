event management accessing
nextEventTarget
	"Return next event target that should be contained in dispatch chain or nil if none.
	Bloc elements build a composition tree, so we want my parent plays a role of the next
	event target within a dispatch chain"
	<return: #TBlEventTarget or: nil>

	^ self parent