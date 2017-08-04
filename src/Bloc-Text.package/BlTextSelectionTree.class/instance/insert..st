accessing
insert: aMonotoneTextSelection
	| theNeighbours |
	self hasRoot
		ifFalse: [ root := BlTextSelectionNode selection: aMonotoneTextSelection. ^ self ].
		
	theNeighbours