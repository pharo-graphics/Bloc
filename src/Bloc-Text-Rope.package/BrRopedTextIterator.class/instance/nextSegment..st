iterator - enumeration
nextSegment: aBlock
	<return: #BrText>

	^ BrRopedText rope: (iterator nextSegment: aBlock)