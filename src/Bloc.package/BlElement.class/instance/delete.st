deleting
delete
	self parent ifNotNil: [ :p | p removeChild: self ]