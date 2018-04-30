anchor - geometry
decoratedAnchorPositions
	<return: #SequenceableCollection of: #Point>
	
	^ {
		self decoratedFromPosition.
		self decoratedToPosition
	}