*Bloc-SVG
attributeAt: aName ifPresent: aBlock
	"returns the value of the attribute whose full name matches aName or the
	value of aBlock if there isn't any"
	| aValue |
	aValue := self attributeNodes
		attributeValueAt: aName
		ifAbsent: [ ^ self ].
	aBlock cull: aValue