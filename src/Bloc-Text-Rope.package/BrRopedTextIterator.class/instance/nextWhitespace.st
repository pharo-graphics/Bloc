iterator - enumeration
nextWhitespace
	"Return an instance of BrText which represents a piece of text from current position
	until the first non-whitespace character without including it"
	<return: #BrText>

	^ BrRopedText rope: iterator nextWhitespace