*Bloc-SVG
attributeAt: aName ifPresent: aBlock
	"returns the value of the attribute whose full name matches aName or the
	value of aBlock if there isn't any"

	^ self attributeNodes
		attributeValueAt: aName
		ifPresent: aBlock