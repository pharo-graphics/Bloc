examples
composed
	<gtExample>
	| container children |

	children := (1 to: 5) collect: [ :index |
		| grid gridChildren |
		gridChildren := (1 to: 20 atRandom + 6) collect: [ :i | self cell ].

		grid := BlElement new.
		grid focusability: BlFocusability after.
		grid background: Color white.
		grid margin: (BlInsets all: 5).
		grid layout: BlGridLayout new.
		grid layout columnCount: (gridChildren size sqrt + 1) rounded.
		grid layout cellSpacing: 2.
		grid constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
		grid addChildren: gridChildren.
		grid addEventHandlerOn: BlFocusEvent do: [ :anEvent | anEvent target border: (BlBorder paint: Color blue width: 2) ].
		grid addEventHandlerOn: BlBlurEvent do: [ :anEvent | anEvent target border: BlBorder empty ].
		grid ].

	container := BlElement new.
	container background: Color veryVeryLightGray.
	container layout: BlLinearLayout vertical.
	container constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	
	container addChildren: children.
	container addEventHandler: BlFocusExampleNavigationListener new.
	
	^ container