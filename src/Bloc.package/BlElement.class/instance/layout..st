api - layout
layout: aBlLayout
	"Change my current layout to a given one.
	After the layout change I request the layout recomputation.
	aBlLayout must not be nil"
	<event: #BlElementLayoutChangedEvent>

	self
		assert: [ aBlLayout isNotNil ]
		description: [ 'Layout must not be nil' ].

	layout := aBlLayout.

	self dispatchEvent: (BlElementLayoutChangedEvent new).
	self requestLayout