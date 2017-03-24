cursor - management
moveCursorsRight: aTextEditElement
	"Move cursors of a text edit element to the left by one letter"
	
	aTextEditElement cursors do: [ :aCursor |
		self moveCursor: aCursor to: aCursor textIndex + 1 in: aTextEditElement ]