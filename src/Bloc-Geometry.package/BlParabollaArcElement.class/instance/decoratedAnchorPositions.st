anchor - geometry
decoratedAnchorPositions
	<return: #SequenceableCollection of: #Point>
	
	^ Array streamContents: [ :aStream |
		aStream nextPut: self decoratedFromPosition.
		aStream nextPut: self curvaturePosition.
		aStream nextPut: self decoratedToPosition ]