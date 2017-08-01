selection - handling
selectionChanged
	"Is sent when #selectionArea changed"
	| oldSelected |

	oldSelected := selected copy.
	selected removeAll.

	self
		selectedChildren: container
		in: self selectionArea
		do: [ :anElement :aSelectionInLocal |
			selected add: anElement.
			oldSelected remove: anElement ifAbsent: [].
			self handleSelected: anElement in: aSelectionInLocal ].
	
	oldSelected do: [ :anElement | self handleDeselected: anElement ]