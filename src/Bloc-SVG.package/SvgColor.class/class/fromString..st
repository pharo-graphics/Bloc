instance creation
fromString: aString
	aString='none' ifTrue:[^self transparent].
	"If aString is following the format: 'rgb(R,G,B)' or 'rgb(R%,G%,B%)':"
	(aString beginsWith: 'rgb(') ifTrue:[^self fromRgbString: aString].
	"If aString is following the format: '#RRGGBB' or '#RGB':"
	(aString beginsWith: '#') ifTrue:[^self fromHexString: aString allButFirst].
	"If aString is a color keyword"
	^super fromString:aString