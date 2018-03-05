examples
verticalExactHorizontalExactChildrenMatchParent
	<gtExample>
	| aContainer aList aListWidth aListHeight anItemHeight anItemCount aVisibleItemCount chunksAdded |
	
	aListWidth := 200.
	anItemHeight := 50.
	anItemCount := 5.
	aVisibleItemCount := 3.
	aListHeight := aVisibleItemCount * anItemHeight.

	aContainer := self container.

	aList := self list.
	aList constraintsDo: [ :c |
		c vertical exact: aListHeight.
		c horizontal exact: aListWidth ].
	aList items: anItemCount.
	aList itemConstraintsDo: [ :c |
		c vertical exact: anItemHeight.
		c horizontal matchParent ].

	chunksAdded := 0.
	aList layoutDo: [ :anInfiniteLayout | anInfiniteLayout when: BlInfiniteLinearLayoutChunkAdded do: [ chunksAdded := chunksAdded + 1 ] ].

	aContainer addChild: aList.
	aContainer forceLayout.

	self assert: aList height equals: aListHeight.
	self assert: aList width equals: aListWidth.
	self assert: aList childrenCount equals: aVisibleItemCount.
	"if infinite list has an exact size in both directions, chunks are added only once"
	self assert: chunksAdded equals: aVisibleItemCount.

	self
		assert: (aList children collect: #extent)
		equals: (aVisibleItemCount timesCollect: [ aListWidth @ anItemHeight ]).

	^ aContainer