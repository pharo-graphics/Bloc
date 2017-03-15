event management accessing
nextEventTarget
	"Return next event target that should be contained in dispatch chain or nil if none.
	Note: returned object must use TBlEventTarget trait!
	Default implementation returns nothing, override me in order to dispatch
	event along your custom object chain"
	<return: #TBlEventTarget or: nil>

	^ nil