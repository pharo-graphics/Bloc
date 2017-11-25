anchor - accessing
anchorPositions
	<return: #SequenceableCollection of: #Point>
	
	^ Array streamContents: [ :aStream |
		aStream nextPut: (self fromAnchor positionWithin: self).
		viaAnchors do: [ :anAnchor |
			aStream nextPut: (anAnchor positionWithin: self) ].
		aStream nextPut: (self toAnchor positionWithin: self) ]