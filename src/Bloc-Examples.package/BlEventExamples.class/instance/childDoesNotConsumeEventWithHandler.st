events - filter
childDoesNotConsumeEventWithHandler
	<gtExample>
	| parent child clicks |
	
	clicks := OrderedCollection new.
	
	parent := self redElement.
	parent relocate: 100@100.
	parent size: 100@100.
	parent addEventHandlerOn: BlClickEvent do: [ :anEvent | anEvent consumed: true. clicks add: Color red ].
	
	child := self blueElement.
	child relocate: 10@10.
	child size: 50@50.
	child addEventHandlerOn: BlClickEvent do: [ :anEvent | anEvent consumed: false. clicks add: Color blue ].
	
	parent addChild: child.
	
	BlSpace simulateClickOn: child.
	self assert: clicks equals: { Color blue . Color red } asOrderedCollection.
	
	^ parent