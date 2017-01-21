enumerating
anySatisfy: aBlock
	"Evaluate aBlock with registered handlers.
	If aBlock returns true for any element return true, otherwise return false."
	<return: #Boolean>

	^ handlers anySatisfy: aBlock