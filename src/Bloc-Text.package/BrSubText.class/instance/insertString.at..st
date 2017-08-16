text - modifications
insertString: aString at: anIndex
	text insertString: aString at: start + anIndex - 1.
	self halt.
	"end := end + aString size"