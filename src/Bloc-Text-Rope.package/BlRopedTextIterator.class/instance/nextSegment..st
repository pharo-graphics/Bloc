iterator - enumeration
nextSegment: aBlock
	<return: #BlText>
	| aStartPosition aSegment |

	aStartPosition := iterator position.
	aSegment := iterator nextSegment: aBlock.

	^ BlSubText text: text from: aStartPosition to: aStartPosition + aSegment size - 1