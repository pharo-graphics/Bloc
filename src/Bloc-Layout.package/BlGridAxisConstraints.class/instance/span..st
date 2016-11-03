accessing
span: aNumber
	"Change how many cells (rows or columns) an element needs to take.
	if span is set to 0 grid will ignore space needs of that element
	which may result in overlapping with neighbor rows or columns.
	aNumber must be greater or equal to 0
	aNumber must not be nil"
	self assert: aNumber isNotNil.
	self assert: aNumber >= 0.

	self specSpan: (self spec span first to: self spec span first + aNumber)