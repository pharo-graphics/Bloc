iterator - enumeration
nextSegment: aBlock
	<return: #BrText>
	| aStartPosition aSegment |
	
	aStartPosition := iterator position.
	aSegment := iterator nextSegment: aBlock.

	^ BrSubText text: text from: aStartPosition to: aStartPosition + aSegment size - 1