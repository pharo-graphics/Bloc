testing
isWhitespace: aCharacter
	"Return true if aCharacter is a whitespace and
	therefore needs to be skipped if appears on a new line AFTER line break.
	Before sending me make sure that you don't skip characters from the start of a paragraph"
	<return: #Boolean>

	^ aCharacter = Character space