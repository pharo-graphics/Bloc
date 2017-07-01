tests
testRender

	self assert: self dirtyAreas equals: { 0@0 extent: space extent }.
	self assert: space hostSpace renderCount equals: 0.
	self assert: space pulseRequested.
	
	space pulse.
	self assert: self dirtyAreas equals: {}.
	self assert: space hostSpace renderCount equals: 1.
	self assert: space pulseRequested not.

	space pulse.
	self assert: self dirtyAreas equals: {}.
	self assert: space hostSpace renderCount equals: 1.
	self assert: space pulseRequested not.
	
	space requestNextPulse.
	self assert: space pulseRequested.
	space pulse.
	self assert: self dirtyAreas equals: {}.
	self assert: space hostSpace renderCount equals: 1.
	self assert: space pulseRequested not.

	space invalidRect: (BlBounds origin: 50@70 extent: 300@200) from: space root.
	self assert: space pulseRequested.
	self assert: self dirtyAreas equals: { 50@70 extent: 300@200 }.
	space pulse.
	self assert: self dirtyAreas equals: {}.
	self assert: space hostSpace renderCount equals: 2.
	self assert: space pulseRequested not.