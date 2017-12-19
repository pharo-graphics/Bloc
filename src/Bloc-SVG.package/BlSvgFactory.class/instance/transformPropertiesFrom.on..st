properties
transformPropertiesFrom: attributes on: aBlElement
	|transformations|
	
	attributes at: 'transform' ifPresent: [ transformations := ((attributes at: 'transform') substrings: ' ')].
	transformations ifNil:[^self].

	transformations do: [:transformation |
		|sel args symbol|
		sel := nil.
		args:=OrderedCollection new.
		(transformation substrings: { $(. $,. $). }) do:[:string | sel ifNil:[sel:=string]
																						ifNotNil: [args add: string asNumber]].
																					
		symbol := (sel , 'Element:with:') asSymbol.
		(self respondsTo: symbol) ifTrue: [self perform: symbol with: aBlElement with: args].
	]