accessing
class: aClass
	| aText |
	class == aClass
		ifTrue: [ ^ self ].

	class := aClass.
	
	aText := SpText fromString: class name.
	aText attributes: { SpFontSizeAttribute size: 13 } from: 1 to: aText size.
	aText attributes: { SpTextWrapAttribute none } from: 1 to: aText size.
	itemElement text: aText