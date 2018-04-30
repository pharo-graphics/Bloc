anchor - geometry
anchorPositions
	<return: #SequenceableCollection of: #Point>

	^ Array streamContents: [ :aStream |
		aStream nextPut: self fromPosition.
		aStream nextPutAll: self curvaturePositions.
		aStream nextPut: self toPosition ]