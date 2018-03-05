examples
verticalExactHorizontalExactChildrenMatchParent
	<gtExample>
	| aContainer aList aListWidth aListHeight anItemHeight anItemCount aVisibleItemCount chunksAdded availableSpaceLog |
	
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
	availableSpaceLog := OrderedCollection new.
	aList layoutDo: [ :anInfiniteLayout |
		anInfiniteLayout
			when: BlInfiniteLinearLayoutChunkAdded
			do: [ chunksAdded := chunksAdded + 1 ].
		anInfiniteLayout
			when: BlInfiniteLinearLayoutAvailableSpaceChanged
			do: [ :anAnnouncement | availableSpaceLog add: anAnnouncement availableSpace ] ].
	
	aContainer addChild: aList.
	aContainer forceLayout.

	self assert: aList height equals: aListHeight.
	self assert: aList width equals: aListWidth.
	self assert: aList childrenCount equals: aVisibleItemCount.
	"if infinite list has an exact size in both directions, chunks are added only once"
	self assert: chunksAdded equals: aVisibleItemCount.
	self assert: availableSpaceLog asArray equals: {
		aListHeight. "available space is computed once before filling from the start (top) to the end (bottom)"
		aListHeight - (anItemHeight * 1). "first item is added"
		aListHeight - (anItemHeight * 2). "second item is added"
		aListHeight - (anItemHeight * 3). "third item is added"
		0 "compute available space to layout from the end (bottom) to the start(top), no space left"
	}.

	self
		assert: (aList children collect: #extent)
		equals: (aVisibleItemCount timesCollect: [ aListWidth @ anItemHeight ]).

	^ aContainer