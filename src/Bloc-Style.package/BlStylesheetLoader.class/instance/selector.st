grammar selector
selector
	^ super selector
		==>
			[ :nodes | 
			| finalSelector theSelectors theRelations |
			theSelectors := OrderedCollection new.
			theRelations := OrderedCollection new.
			nodes
				withIndexDo:
					[ :item :index | 
					index % 2 = 1
						ifTrue: [ theSelectors add: (self createSimpleSelector: item) ]
						ifFalse: [ theRelations add: item ] ].
			theSelectors size = 1
				ifTrue: [ finalSelector := theSelectors first ]
				ifFalse:
					[ finalSelector := BlStyleCompoundSelector new
						selectors: theSelectors;
						relationships: theRelations;
						update;
						yourself ].
			finalSelector ]