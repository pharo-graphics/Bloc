accessing
weight: aNumber
	"Set new weight value that defines how much space an element takes within parent's available space.
	aNumber must not be nil
	aNumber must be non negative"
	self assert: aNumber isNotNil description: 'weight can not be nil'.
	self assert: aNumber >= 0 description: 'weight must be non negative'.
	
	weight := aNumber