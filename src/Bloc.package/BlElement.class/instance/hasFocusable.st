focus testing
hasFocusable
	"Returns true if I am focusable or if I contain a reachable child for which #hasFocusable returns true,
	false otherwise"
	<return: #Boolean>

	^ self isFocusable or: [
		self children anySatisfy: [ :anElement | anElement hasFocusable ] ]