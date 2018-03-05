examples
verticalFitContentHorizontalExactChildrenMatchParentWithMinHeight
	<gtExample>
	| aList aListWidth aListMinHeight anItemHeight anItemCount aVisibleItemCount |
	
	aListWidth := 200.
	anItemHeight := 50.
	anItemCount := 5.
	
	"min height is more then total height of %anItemCount% children"
	aListMinHeight := 500.
	aVisibleItemCount := anItemCount.

	aList := self list.
	aList constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal exact: aListWidth.
		c minHeight: aListMinHeight ].
	aList items: anItemCount.
	aList itemConstraintsDo: [ :c |
		c vertical exact: anItemHeight.
		c horizontal matchParent ].

	aList forceLayout.
	self assert: aList height equals: aListMinHeight.
	self assert: aList width equals: aListWidth.
	self assert: aList childrenCount equals: aVisibleItemCount.
	self
		assert: (aList children collect: #extent)
		equals: (aVisibleItemCount timesCollect: [ aListWidth @ anItemHeight ]).

	^ aList