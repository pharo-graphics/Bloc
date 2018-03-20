changes
onWidthChanged: aNumber

	self size: aNumber * self scale asPoint.
	self border: (self border copyWithWidth: aNumber)