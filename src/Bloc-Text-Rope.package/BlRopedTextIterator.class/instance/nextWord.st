iterator - enumeration
nextWord
	"Return an instance of BrText which represents a piece of text from current position
	until the first space character not including spaces"
	<return: #BlText>
	| aStartPosition aSegment |
	
	aStartPosition := iterator position.
	aSegment :=  iterator nextWord.

	^ BlSubText text: text from: aStartPosition to: aStartPosition + aSegment size - 1	

	"^ BrRopedText rope: iterator nextWord"