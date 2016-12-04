children accessing
unfilteredChildrenDo: aBlock
	"Do not remove children in a Block!"
	| aChildCount |
	aChildCount := self unfilteredChildrenCount.
	1 to: aChildCount do: [ :anIndex |
		aBlock value: (self unfilteredChildAt: anIndex) ]