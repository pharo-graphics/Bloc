accessing
registeredNameOf: aColor 
	| colorName |
	colorName := #unnamed.
	SVGColorRegistry keysAndValuesDo: [:key :value|  value = aColor ifTrue: [ colorName := key ] ].
	^ colorName 