text - modifications
delete: aStart to: anEnd
	rope := rope delete: aStart to: anEnd.
	self notifyDeleted: aStart to: anEnd