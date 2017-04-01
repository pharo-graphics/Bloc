iterator - testing
isNewLine: anItem
	"Return true of given item represents a carriage return, false otherwise"
	<return: #Boolean>

	^ anItem = Character cr or: [ anItem = Character lf ]