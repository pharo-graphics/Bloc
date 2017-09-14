definitions
symbolFrom: node
	"Behaves like a 'svg' but won't be added to any parent because is always a reference, see 'XMLElement >> translatedBy:withParent:' "
	^self svgFrom:node