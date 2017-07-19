text - modifications
insertString: aString at: aTextIndex in: aTextEditElement
	"Insert a given string in a provided text edit element.
	The exact location of an inserted string is determined by current cursor location"
	| aText |

	aText := aTextEditElement text.

	aText
		insertString: aString
		at: aTextIndex.

	aTextEditElement textChanged.

	self
		moveCursorRight: aTextEditElement
		by: aString size