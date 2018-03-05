examples
verticalFitContentHorizontalExactChildrenMatchParent
	<gtExample>
	| aList aListWidth anItemHeight anItemCount |
	
	aListWidth := 200.
	anItemHeight := 50.
	anItemCount := 5.
	
	aList := self list.
	aList constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal exact: aListWidth ].
	aList items: anItemCount.
	aList itemConstraintsDo: [ :c |
		c vertical exact: anItemHeight.
		c horizontal matchParent ].

	aList forceLayout.
	self assert: aList height equals: (anItemCount * anItemHeight).
	self assert: aList width equals: aListWidth.
	self assert: aList childrenCount equals: anItemCount.
	
	self
		assert: (aList children collect: #extent)
		equals: (anItemCount timesCollect: [ aListWidth @ anItemHeight ]).

	^ aList