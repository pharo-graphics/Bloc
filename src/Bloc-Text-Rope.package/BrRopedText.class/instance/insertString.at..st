text - modifications
insertString: aString at: anIndex
	rope := rope insertItems: aString at: anIndex.
	self notifyStringInserted: aString at: anIndex