cursor - management
moveCursorsLeft: aTextEditElement
	"Move cursors of a text edit element to the left by one letter"

	aTextEditElement cursors do: [ :aCursor |
		self moveCursorLeft: aCursor in: aTextEditElement ]