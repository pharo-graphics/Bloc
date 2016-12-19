accessing
class: aClass
	class == aClass
		ifTrue: [ ^ self ].

	class := aClass.
	
	"color changed, update element to represent new color"
	itemElement label: class name