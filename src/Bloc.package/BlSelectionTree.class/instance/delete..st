tree - deletion
delete: aMonotoneTextSelection
	| theOverlapping |
	self hasRoot
		ifFalse: [ ^ self ].
		
	theOverlapping := self findOverlapping: aMonotoneTextSelection.
	theOverlapping
		ifEmpty: [ ^ self ].
	
	theOverlapping reverseDo: #delete.
	
	theOverlapping
		collect: [ :aSelectionNode | aSelectionNode selection complement: aMonotoneTextSelection ]
		thenDo: [ :aComplementSelection | aComplementSelection
			do: [ :aSelection | aSelection isNotEmpty ifTrue: [ self insert: aSelection ] ] ]