converting
asElement
	<return: #BlElement>

	^ BlLineElement new
		border: (BlBorder builder paint: Color gray; width: 2; build);
		fromAnchor: (BlAbsolutePositionAnchor position: self from);
		toAnchor: (BlAbsolutePositionAnchor position: self to);
		yourself