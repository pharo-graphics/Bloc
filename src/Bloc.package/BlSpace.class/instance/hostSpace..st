host - accessing
hostSpace: aHostSpace
	"Assign a host space window that will be a source of UI events
	and will provide a rendering surface on which I will be rendered.
	aHostSpace must not be nil"

	self
		assert: [ aHostSpace isNotNil ]
		description: [ 'Host space must not be nil!' ].

	self hostSpaceProperty value: aHostSpace.
	self hostSpaceChanged.