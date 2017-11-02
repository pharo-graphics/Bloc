accessing
class: aClass
	| aText |
	class == aClass
		ifTrue: [ ^ self ].

	class := aClass.
	
	aText := BrRopedText string: class name.
	aText attributes: { BrFontSizeAttribute size: 13 }.
	itemElement text: aText