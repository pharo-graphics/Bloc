notifying
commitChange: anNewValue on: anElement
	"Send an event letting element's event handlers know that a property changed.
	Should be done once"
	
	self subclassResponsibility