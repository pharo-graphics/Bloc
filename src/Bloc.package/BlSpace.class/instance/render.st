pulse
render
	"Render this space in my host window if it is assigned, otherwise do nothing"

	self
		assert: [ self hasDirtyAreas ]
		description: [ 'I must have dirty areas in order to be rendered' ].

	self hostSpace
		ifNotNil: [ :aHostSpace | BlBenchmarkLogger named: #renderTime on: [ aHostSpace render: self ] ]