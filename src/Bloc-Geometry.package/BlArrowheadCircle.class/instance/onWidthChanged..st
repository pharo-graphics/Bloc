changes
onWidthChanged: aNumber

	self size: aNumber * 3 asPoint.
	self border: (self border copyWithWidth: aNumber).
	self margin: (BlInsets left: aNumber / 2.0)