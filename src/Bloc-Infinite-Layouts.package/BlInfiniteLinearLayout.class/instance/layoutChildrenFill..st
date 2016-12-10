layout
layoutChildrenFill: anExtraSpace
	"fill towards start, stacking from bottom
	fill towards end, stacking from top"
	<return: #Point>

	^ anchorInfo layoutFromEnd
		ifTrue: [ self layoutChildrenFillFromEnd: anExtraSpace ]
		ifFalse: [ self layoutChildrenFillFromStart: anExtraSpace ]