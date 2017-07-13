iterator - enumeration
nextLine
	"Return an instance of BrText which represents a piece of text from current position
	until the first carriage return character"
	<return: #BrText>
	| aStartPosition aNextLine |
	
	aStartPosition := iterator position.
	aNextLine := iterator nextLine.
	
	^ BrSubText text: text from: aStartPosition to: aStartPosition + aNextLine size - 1
	
	"^ BrRopedText rope: iterator nextLine"