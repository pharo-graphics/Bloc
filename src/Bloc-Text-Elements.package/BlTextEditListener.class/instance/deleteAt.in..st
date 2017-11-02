text - modifications
deleteAt: aTextIndex in: aTextEditElement
	| aText |

	aText := aTextEditElement text.

	aText
		delete: aTextIndex
		to: aTextIndex.

	aTextEditElement textChanged.

	self
		moveCursorTo: ((aTextIndex - 1) max: 0)
		in: aTextEditElement