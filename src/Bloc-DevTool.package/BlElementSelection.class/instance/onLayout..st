layout
onLayout: aBounds
	super onLayout: aBounds.

	"put remove button to the top left corner"
	removeButton position: 0@0.

	"put inspect button to the bottom left corner"
	inspectButton position:  0@ (self height - inspectButton height).

	"put resize button to the bottom right corner"
	resizeButton position: self extent - (resizeButton width @ resizeButton height)