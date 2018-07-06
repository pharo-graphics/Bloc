text - testing
isEmpty
	"Return true if this text is empty, false otherwise.
	Note: Override me to provide performance optimized implementation"
	<return: #Boolean>

	^ self subclassResponsibility