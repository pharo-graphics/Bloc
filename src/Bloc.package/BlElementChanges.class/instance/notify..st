notifying
notify: anElement
	"Let all recorded changes notify a given element.
	All changes are removed after notification"
	
	self changesDo: [ :aChange | aChange hasActiveChanges ifTrue: [ aChange notify: anElement ] ]