translating
generateElementFrom: node
	| symbol |
	node splitStyleAttribute; inheriteAttributes.
	
	symbol := (node name asString , 'From:') asSymbol.
	
	(self respondsTo: symbol)
		ifTrue: [ ^ self perform: symbol with: node ]
		ifFalse: [ ^ self metadataFrom: node ]