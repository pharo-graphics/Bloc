anchor - geometry
decoratedAnchorPositions
	<return: #SequenceableCollection of: #Point>
	
	^ Array streamContents: [ :aStream |
		aStream nextPut: self decoratedFromPosition.
		aStream nextPutAll: self curvaturePositions.
		aStream nextPut: self decoratedToPosition ]