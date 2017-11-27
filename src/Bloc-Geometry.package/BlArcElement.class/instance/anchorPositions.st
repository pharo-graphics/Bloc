anchor - geometry
anchorPositions
	<return: #SequenceableCollection of: #Point>
	
	^ Array streamContents: [ :aStream |
		aStream nextPut: self fromPosition.
		aStream nextPut: (self curvatureAnchor positionWithin: self).
		aStream nextPut: self toPosition ]