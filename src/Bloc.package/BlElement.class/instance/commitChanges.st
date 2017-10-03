change reporting
commitChanges
	"Commit all accumulated element changes since previous commit"

	self changes commitOn: self.
	self childrenDo: [ :anElement | anElement commitChanges ]