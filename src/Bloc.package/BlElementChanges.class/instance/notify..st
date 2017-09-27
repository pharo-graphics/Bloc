notifying
notify: anElement
	"Let all recorded changes notify a given element.
	All changes are removed after notification"
	| theChanges |
	
	theChanges := changeMap values.
	changeMap removeAll.

	theChanges do: [ :aChange | aChange notify: anElement ]