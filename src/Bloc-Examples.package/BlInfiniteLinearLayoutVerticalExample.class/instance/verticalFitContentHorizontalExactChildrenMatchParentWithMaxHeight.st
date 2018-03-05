examples
verticalFitContentHorizontalExactChildrenMatchParentWithMaxHeight
	<gtExample>
	| aContainer aList aListWidth aListMaxHeight anItemHeight anItemCount aVisibleItemCount chunksAdded |
	
	aListWidth := 200.
	anItemHeight := 50.
	anItemCount := 5.
	
	"max height is less then the total height of %anItemCount% children"
	aListMaxHeight := 120.
	aVisibleItemCount := 3.

	aContainer := self container.

	aList := self list.
	aList constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal exact: aListWidth.
		c maxHeight: aListMaxHeight ].
	aList items: anItemCount.
	aList itemConstraintsDo: [ :c |
		c vertical exact: anItemHeight.
		c horizontal matchParent ].
	chunksAdded := 0.
	aList layoutDo: [ :anInfiniteLayout | anInfiniteLayout when: BlInfiniteLinearLayoutChunkAdded do: [ chunksAdded := chunksAdded + 1 ] ].
	
	aContainer addChild: aList.
	aContainer forceLayout.
	
	self assert: aList height equals: aListMaxHeight.
	self assert: aList width equals: aListWidth.
	self assert: aList childrenCount equals: aVisibleItemCount.
	"in case of non exact infinite list, chunks are added twice;
	once during measurement and one more time during layout steps"
	self assert: chunksAdded equals: aVisibleItemCount * 2.
	self
		assert: (aList children collect: #extent)
		equals: (aVisibleItemCount timesCollect: [ aListWidth @ anItemHeight ]).

	^ aContainer