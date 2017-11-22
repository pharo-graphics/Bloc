accessing
class: aClass
	| aText |

	class := aClass.
	aText := class name asRopedText.
	aText attributes: { BrFontSizeAttribute size: 13 }.
	itemElement text: aText