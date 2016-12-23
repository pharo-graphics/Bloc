accessing
class: aClass
	| aText |
	class == aClass
		ifTrue: [ ^ self ].

	class := aClass.
	
	aText := SpText fromString: class name.
	aText attributes: { SpFontSizeAttribute size: 13 } from: 1 to: aText size.
	"color changed, update element to represent new color"
	itemElement text: aText