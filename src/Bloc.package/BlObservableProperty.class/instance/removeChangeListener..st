change management
removeChangeListener: aListener
	"Remove the argument from the list of listeners, if it was not there do nothing."
	changeListeners remove: aListener ifAbsent: [ nil ]