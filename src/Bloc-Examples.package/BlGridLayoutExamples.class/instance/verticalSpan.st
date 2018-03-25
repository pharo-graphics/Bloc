examples
verticalSpan
	<gtExample>
	| grid child1 child2 child3 |

	grid := BlElement new.
	grid size: 500@400.
	grid layout: (BlGridLayout horizontal cellSpacing: 10; columnCount: 2).

	child1 := BlElement new.
	child1 background: (Color red alpha: 0.5).
	child1 constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	child2 := BlElement new.
	child2 background: (Color blue alpha: 0.5).
	child2 constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent.
		c grid vertical span: 2 ].

	child3 := BlElement new.
	child3 background: (Color green alpha: 0.5).
	child3 constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	grid addChildren: { child1. child2. child3 }.

	grid forceLayout.
	self assert: grid extent equals: 500@400.
	self assert: child1 position equals: 10@10.
	self assert: child1 extent equals: 235@185.
	
	self assert: child2 position equals: 255@10.
	self assert: child2 extent equals: 235@380.
	
	self assert: child3 position equals: 10@205.
	self assert: child3 extent equals: 235@185.

	^ grid