examples
extentChanged
	<gtExample>
	| extentChanged element |
	extentChanged := 0.
	
	element := self child.
	"make sure initial extent is computed"
	element forceLayout.	
	element addEventHandlerOn: BlElementExtentChangedEvent do: [ extentChanged := extentChanged + 1 ].

	"change size and force compute layout"
	element size: element extent * 2.
	element forceLayout.
	self assert: extentChanged equals: 1.
	
	"requesting the same size should not trigger event"
	element size: element extent.
	element forceLayout.
	self assert: extentChanged equals: 1.

	^ element