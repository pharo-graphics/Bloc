anchor - geometry
anchorPositions
	<return: #SequenceableCollection of: #Point>
	
	^ Array streamContents: [ :aStream |
		aStream nextPut: (self fromAnchor positionWithin: self).
		aStream nextPut: (self curvatureAnchor positionWithin: self).
		aStream nextPut: (self toAnchor positionWithin: self) ]