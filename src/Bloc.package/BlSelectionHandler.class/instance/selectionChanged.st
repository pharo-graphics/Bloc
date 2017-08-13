selection - handling
selectionChanged
	"Is sent when #selectionArea changed"
	| oldSelected |

	oldSelected := selected copy.
	selected removeAll.

	self
		selectedChildren: container
		in: (container globalBoundsToLocal: self selectionArea copy)
		do: [ :anElement :aSelectionInLocal |
			| anIntersectionInLocal isSelectionChanged |
			
			anIntersectionInLocal := self
				intersect: anElement
				in: aSelectionInLocal
				ifNone: [ self error: 'Selected child must intersect with selection' ].
			
			oldSelected
				at: anElement
				ifPresent: [ :anExistingIntersection | isSelectionChanged := anExistingIntersection ~= anIntersectionInLocal ]
				ifAbsent: [ isSelectionChanged := true ].
			
			selected
				at: anElement
				put: anIntersectionInLocal.
			
			oldSelected removeKey: anElement ifAbsent: [].

			"return true / false if selection event was consumed (handled)"
			isSelectionChanged
				ifTrue: [ self handleSelected: anElement in: anIntersectionInLocal ]
				ifFalse: [ true ] ].
	
	oldSelected keysDo: [ :anElement | self handleDeselected: anElement ]