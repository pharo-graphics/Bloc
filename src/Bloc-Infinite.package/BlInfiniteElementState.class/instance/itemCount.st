testing
itemCount
	^ inPreLayout
		ifTrue: [ previousLayoutItemCount - deletedInvisibleItemCountSincePreviousLayout ]
		ifFalse: [ itemCount ]