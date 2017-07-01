examples
linearVertical
	<gtExample>
	| container children |

	children := (1 to: 10) collect: [ :index |
		self cell size: 200@50; margin: (BlInsets all: 2)  ].

	container := BlElement new.
	container layout: BlLinearLayout vertical.
	container constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	
	container addChildren: children.
	container addEventHandler: BlFocusExampleNavigationListener new.
	
	^ container