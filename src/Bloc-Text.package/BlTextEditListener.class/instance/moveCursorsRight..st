cursor - management
moveCursorsRight: aTextEditElement
	"Move cursors of a text edit element to the left by one letter"
	
	aTextEditElement cursors do: [ :aCursor |
		self moveCursorRight: aCursor in: aTextEditElement ]