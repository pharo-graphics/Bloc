anchor - geometry
anchorPositions
	<return: #SequenceableCollection of: #Point>
	
	^ Array streamContents: [ :aStream |
		aStream nextPut: self fromPosition.
		aStream nextPut: self curvaturePosition.
		aStream nextPut: self toPosition ]