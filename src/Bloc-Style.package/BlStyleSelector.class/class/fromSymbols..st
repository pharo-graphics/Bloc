as yet unclassified
fromSymbols: aSymbolList
	| selectors relationships |
	selectors := OrderedCollection new.
	relationships := OrderedCollection new.
	aSymbolList
		do:
			[ :aSymb | 
			aSymb = #>
				ifTrue: [ relationships add: BlStyleRelation CHILD ]
				ifFalse:
					[ 
					(aSymb = aSymbolList first) not
						ifTrue: [ relationships add: BlStyleRelation DESCENDANT ].
					selectors add: (self fromSymbol: aSymb) ] ].
	^ (BlStyleCompoundSelector selectors: selectors relationships: relationships)
		update;
		yourself