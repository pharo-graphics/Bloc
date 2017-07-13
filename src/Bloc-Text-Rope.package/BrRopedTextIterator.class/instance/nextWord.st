iterator - enumeration
nextWord
	"Return an instance of BrText which represents a piece of text from current position
	until the first space character not including spaces"
	<return: #BrText>
	"| aStartPosition aSegment |
	
	aStartPosition := iterator position.
	aSegment :=  iterator nextWord.

	^ BrSubText text: text from: aStartPosition to: aStartPosition + aSegment size - 1	
"
	^ BrRopedText rope: iterator nextWord