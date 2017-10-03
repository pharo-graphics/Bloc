change reporting
notifyChanges
	"Let element changes (since previous announcement) to be announced in a form of element events"
	
	self changes notify: self.
	self childrenDo: [ :anElement | anElement notifyChanges ]