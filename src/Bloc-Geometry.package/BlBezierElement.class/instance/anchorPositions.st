anchor - geometry
anchorPositions
	<return: #SequenceableCollection of: #Point>
	
	^ Array streamContents: [ :aStream |
		aStream nextPut: self fromPosition.
		viaAnchors do: [ :anAnchor |
			aStream nextPut: (anAnchor positionWithin: self) ].
		aStream nextPut: self toPosition ]