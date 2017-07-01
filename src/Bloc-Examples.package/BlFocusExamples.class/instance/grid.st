examples
grid
	<gtExample>
	| container children |

	children := (1 to: 50) collect: [ :index |
		self cell ].

	container := BlElement new.
	container layout: BlGridLayout new.
	container layout columnCount: 8.
	container layout cellSpacing: 5.
	container constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	
	container addChildren: children.
	container addEventHandler: BlFocusExampleNavigationListener new.
	
	^ container