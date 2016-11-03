text wrapping
wrappingWidth: aNumber
	wrappingWidth := aNumber.
	aNumber > 0
		ifTrue: [ layoutView layoutStrategy: TxAthensCharacterWrappingStrategy new ]
		ifFalse: [ layoutView layoutStrategy: TxAthensNoWrapStrategy new ].
	self wrappingChanged