grid
specSpan: aSpan
	"aSpan is an instance of Interval and must not be nil"
	self assert: aSpan isNotNil.

	spec := spec copyWithSpan: aSpan