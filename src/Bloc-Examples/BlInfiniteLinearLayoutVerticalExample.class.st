"
I contain examples of a vertical linear layout
"
Class {
	#name : #BlInfiniteLinearLayoutVerticalExample,
	#superclass : #Object,
	#category : 'Bloc-Examples-Infinite'
}

{ #category : #'instance creation' }
BlInfiniteLinearLayoutVerticalExample >> container [
	<gtExample>
	
	^ BlElement new size: 500@500
]

{ #category : #'instance creation' }
BlInfiniteLinearLayoutVerticalExample >> list [
	<gtExample>

	^ BlInfiniteLinearLayoutExampleElement new
		relocate: 20@20;
		border: (BlBorder paint: Color blue width: 2);
		outskirts: BlOutskirts outside
]

{ #category : #examples }
BlInfiniteLinearLayoutVerticalExample >> verticalExactHorizontalExactChildrenMatchParent [
	<gtExample>
	<noTest>
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
]

{ #category : #examples }
BlInfiniteLinearLayoutVerticalExample >> verticalFitContentHorizontalExactChildrenMatchParent [
	<gtExample>
	<noTest>
	| aContainer aList aListWidth anItemHeight anItemCount chunksAdded |
	
	aListWidth := 200.
	anItemHeight := 50.
	anItemCount := 5.

	aContainer := self container.

	aList := self list.
	aList constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal exact: aListWidth ].
	aList items: anItemCount.
	aList itemConstraintsDo: [ :c |
		c vertical exact: anItemHeight.
		c horizontal matchParent ].

	chunksAdded := 0.
	aList layoutDo: [ :anInfiniteLayout | anInfiniteLayout when: BlInfiniteLinearLayoutChunkAdded do: [ chunksAdded := chunksAdded + 1 ] ].

	aContainer addChild: aList.
	aContainer forceLayout.

	self assert: aList height equals: (anItemCount * anItemHeight).
	self assert: aList width equals: aListWidth.
	self assert: aList childrenCount equals: anItemCount.
	"in case of non exact infinite list, chunks are added twice;
	once during measurement and one more time during layout steps"
	self assert: chunksAdded equals: anItemCount * 2.

	self
		assert: (aList children collect: #extent)
		equals: (anItemCount timesCollect: [ aListWidth @ anItemHeight ]).

	^ aContainer
]

{ #category : #examples }
BlInfiniteLinearLayoutVerticalExample >> verticalFitContentHorizontalExactChildrenMatchParentWithMaxHeight [
	<gtExample>
	<noTest>
	| aContainer aList aListWidth aListMaxHeight anItemHeight anItemCount aVisibleItemCount chunksAdded availableSpaceLog |
	
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
	
	self assert: aList height equals: aListMaxHeight.
	self assert: aList width equals: aListWidth.
	self assert: aList childrenCount equals: aVisibleItemCount.
	"in case of non exact infinite list, chunks are added twice;
	once during measurement and one more time during layout steps"
	self assert: chunksAdded equals: aVisibleItemCount * 2.
	self assert: availableSpaceLog asArray equals: {
		"first pass"
	
		aListMaxHeight. "initially, available height should be equal to max height"
		aListMaxHeight - (anItemHeight * 1). "first item is added"
		aListMaxHeight - (anItemHeight * 2). "second item is added"
		aListMaxHeight - (anItemHeight * 3). "third item is added"
		0. "compute available space to layout from the end (bottom) to the start(top), no space left"
		
		"second pass"
		aListMaxHeight. "initially, available height should be equal to max height"
		aListMaxHeight - (anItemHeight * 1). "first item is added"
		aListMaxHeight - (anItemHeight * 2). "second item is added"
		aListMaxHeight - (anItemHeight * 3). "third item is added"
		0
	}.
	
	self
		assert: (aList children collect: #extent)
		equals: (aVisibleItemCount timesCollect: [ aListWidth @ anItemHeight ]).

	^ aContainer
]

{ #category : #examples }
BlInfiniteLinearLayoutVerticalExample >> verticalFitContentHorizontalExactChildrenMatchParentWithMinHeight [
	<gtExample>
	| aList aListWidth aListMinHeight anItemHeight anItemCount aVisibleItemCount |
	
	aListWidth := 200.
	anItemHeight := 50.
	anItemCount := 5.
	
	"min height is greater then the total height of %anItemCount% children"
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
]
