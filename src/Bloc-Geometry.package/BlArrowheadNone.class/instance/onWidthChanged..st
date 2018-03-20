changes
onWidthChanged: aNumber
	self size: 0 asPoint.
	self border: (self border copyWithWidth: 0)