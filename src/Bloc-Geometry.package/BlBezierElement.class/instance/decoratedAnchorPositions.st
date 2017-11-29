anchor - geometry
decoratedAnchorPositions
	<return: #SequenceableCollection of: #Point>
	
	^ Array streamContents: [ :aStream |
		aStream nextPut: self decoratedFromPosition.
		viaAnchors do: [ :anAnchor |
			aStream nextPut: (anAnchor positionWithin: self) ].
		aStream nextPut: self decoratedToPosition ]