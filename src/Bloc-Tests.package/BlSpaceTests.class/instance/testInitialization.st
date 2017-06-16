tests
testInitialization

	"Host space must not be nil"
	self assert: space hostSpace isNotNil.
	
	"Space must request pulse when just created"
	self assert: space pulseRequested.
	
	"Space must have its whole area being dirty"
	self assert: space dirtyAreas asArray equals: { 0@0 extent: space extent }.