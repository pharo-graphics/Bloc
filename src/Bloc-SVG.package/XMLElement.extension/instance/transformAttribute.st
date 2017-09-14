*Bloc-SVG
transformAttribute
	self attributeAt: 'transform' ifAbsent: [ ^'' ].
	^self attributeAt: 'transform'