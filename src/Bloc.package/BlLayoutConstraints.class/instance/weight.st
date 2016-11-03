accessing
weight
	"Return weight that defines how much space an element takes within parent's available space.
	weight can not be nil and is always non negative"
	<return: #Number>
	self assert: weight isNotNil description: 'weight can not be nil'.
	self assert: weight >= 0 description: 'weight must be non negative'.
	
	^ weight