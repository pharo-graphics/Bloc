committing
commitOn: anElement
	"Commit all accumulated changes done to the given element.
	As the result, all changes are marked as comitted"

	self changesDo: [ :aChange | aChange hasActiveChanges ifTrue: [ aChange notify: anElement ] ]