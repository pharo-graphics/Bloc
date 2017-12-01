changes
onWidthChanged: aNumber

	self size: aNumber * 3 asPoint.
	self border: (self border copyWithWidth: aNumber)