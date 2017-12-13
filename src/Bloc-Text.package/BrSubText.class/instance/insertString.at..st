text - modifications
insertString: aString at: anIndex
	text insertString: aString at: start + anIndex - 1.
	end := end + aString size