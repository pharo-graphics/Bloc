initialization
defaultCursor
	"Create and return a new instance of a cursor element"
	<return: #BlElement>

	^ BlCursorElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal exact: 1.
			c vertical matchParent ];
		background: Color black