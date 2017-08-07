testing
isEmpty
	"Return true if I don't have any spans, false otherwise.
	After measurement process there must be at least one (empty) span!"
	<return: #Boolean>

	^ self subclassResponsibility