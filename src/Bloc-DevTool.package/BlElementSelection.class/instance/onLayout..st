layout
onLayout: aBounds
	super onLayout: aBounds.

	"put remove button to the top left corner"
	removeButton position: 0@0 extent: removeButton extent.

	"put inspect button to the bottom left corner"
	inspectButton position:  0@ (aBounds height - inspectButton height) extent: inspectButton extent.

	"put resize button to the bottom right corner"
	resizeButton position: aBounds extent - (resizeButton width @ resizeButton height) extent: resizeButton extent