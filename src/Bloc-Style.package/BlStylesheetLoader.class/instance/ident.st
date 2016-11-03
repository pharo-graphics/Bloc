grammar value
ident
	^ super ident ==> [ :nodes | (self convertPropertyName: nodes) asSymbol ]