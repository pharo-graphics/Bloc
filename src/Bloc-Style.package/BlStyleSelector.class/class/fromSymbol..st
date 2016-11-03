as yet unclassified
fromSymbol: aSymbol
	| parts selector |
	parts := BlStyleHelper splitSelectorSymbol: aSymbol.
	selector := BlStyleSimpleSelector new
		name: nil;
		styleClasses: {parts first asSymbol};
		id: nil;
		yourself.
	parts size > 1
		ifTrue:
			[ 
			selector pseudoClasses
				addAll: (parts allButFirst collect: [ :each | BlState fromSymbol: each asSymbol ]) ].
	selector update.
	^ selector