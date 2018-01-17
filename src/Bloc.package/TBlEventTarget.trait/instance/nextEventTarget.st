event management accessing
nextEventTarget
	"Return next event target that should be contained in dispatch chain.
	Note: returned object must use TBlEventTarget trait!"
	<return: #TBlEventTarget>

	self error: 'Override me if there is a next event target.'