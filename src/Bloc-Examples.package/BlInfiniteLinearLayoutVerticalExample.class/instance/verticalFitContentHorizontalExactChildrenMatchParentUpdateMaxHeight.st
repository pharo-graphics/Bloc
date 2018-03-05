examples
verticalFitContentHorizontalExactChildrenMatchParentUpdateMaxHeight
	<gtExample>
	| aList aListWidth aListMaxHeight anItemHeight anItemCount aVisibleItemCount |
	
	aListWidth := 200.
	anItemHeight := 50.
	anItemCount := 5.
	
	"max height is less then the total height of %anItemCount% children"
	aListMaxHeight := 160.
	aVisibleItemCount := 4.
	
	aList := self verticalFitContentHorizontalExactChildrenMatchParentWithMaxHeight.
	aList constraintsDo: [ :c | c maxHeight: aListMaxHeight ].
	
	aList forceLayout.
	self assert: aList height equals: aListMaxHeight.
	self assert: aList width equals: aListWidth.
	self assert: aList childrenCount equals: aVisibleItemCount.
	self
		assert: (aList children collect: #extent)
		equals: (aVisibleItemCount timesCollect: [ aListWidth @ anItemHeight ]).

	^ aList