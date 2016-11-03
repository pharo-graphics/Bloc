accessing
zIndex: anObject
	zIndex := anObject.
	self parent ifNotNil:[:p| p children zReSort]