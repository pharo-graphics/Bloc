testing
isNotEmpty
	"Return true if I have at least one (even empty) span, false otherwise.
	After measurement process there must be at least one (empty) span!"
	<return: #Boolean>

	^ self isEmpty not