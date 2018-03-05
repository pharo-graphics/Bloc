examples
verticalFitContentHorizontalExactChildrenMatchParentWithMaxHeight
	<gtExample>
	| aList aListWidth aListMaxHeight anItemHeight anItemCount aVisibleItemCount |
	
	aListWidth := 200.
	anItemHeight := 50.
	anItemCount := 5.
	
	"max height is less then total height of %anItemCount% children"
	aListMaxHeight := 120.
	aVisibleItemCount := 3.
	
	aList := self list.
	aList constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal exact: aListWidth.
		c maxHeight: aListMaxHeight ].
	aList items: anItemCount.
	aList itemConstraintsDo: [ :c |
		c vertical exact: anItemHeight.
		c horizontal matchParent ].

	aList forceLayout.
	self assert: aList height equals: aListMaxHeight.
	self assert: aList width equals: aListWidth.
	self assert: aList childrenCount equals: aVisibleItemCount.
	self
		assert: (aList children collect: #extent)
		equals: (aVisibleItemCount timesCollect: [ aListWidth @ anItemHeight ]).

	^ aList