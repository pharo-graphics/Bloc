*Bloc-SVG
attributeValueAt: aName ifPresent: aBlock
	^ (self
		at: (self indexOfAttribute: aName)
		ifPresent: [^ aBlock value]) value