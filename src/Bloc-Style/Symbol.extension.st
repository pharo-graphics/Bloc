Extension { #name : #Symbol }

{ #category : #'*Bloc-Style' }
Symbol >> asBl2StyleValue [
	^ Bl2SymbolValue value: self
]

{ #category : #'*Bloc-Style' }
Symbol >> asBlStyleValue [
	^ BlSymbolValue value: self
]
