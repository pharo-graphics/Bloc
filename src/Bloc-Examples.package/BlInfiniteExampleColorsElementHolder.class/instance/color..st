accessing
color: aColor

	color = aColor
		ifTrue: [ ^ self ].

	color := aColor.
	
	"color changed, update element to represent new color"
	itemElement background: color