computing styles
apply
	| matchingStyles matchingTransitions |
	matchingStyles := self matchingStyleMap.
	matchingTransitions := self matchingTransitions.
	matchingStyles ifNotEmpty:
			[ self styleProperties do: [ :p | |newVal|
					newVal := nil.
					matchingStyles at: p ifPresent: [ :v | newVal := v transition: (matchingTransitions at: p ifAbsent: [ nil ])].
					self perform: (p,':') asSymbol with: (newVal )
					 ]].
	self children do: [ :each | each apply ].