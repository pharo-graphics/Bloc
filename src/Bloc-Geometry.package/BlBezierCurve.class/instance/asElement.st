converting
asElement
	<return: #BlElement>

	self
		assert: [ self order >= 2 ]
		description: [ 'Only Bezier curve of order 2 or higher can be converted to an element' ].

	^ BlBezierElement new
		border: (BlBorder builder paint: Color gray; width: 2; build);
		fromAnchor: (BlAbsolutePositionAnchor position: self controlPoints first);
		toAnchor: (BlAbsolutePositionAnchor position: self controlPoints last);
		in: [ :anElement | 2 to: self controlPoints size - 1 do: [ :anIndex | 
				anElement viaAnchor: (BlAbsolutePositionAnchor position: (self controlPoints at: anIndex)) ] ];
		yourself