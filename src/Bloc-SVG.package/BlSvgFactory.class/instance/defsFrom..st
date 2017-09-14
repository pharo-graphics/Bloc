definitions
defsFrom: node
	"Behaves like a 'g' but won't be added to any parent because always contains references, see 'XMLElement >> translatedBy:withParent:' "
	^self gFrom:node