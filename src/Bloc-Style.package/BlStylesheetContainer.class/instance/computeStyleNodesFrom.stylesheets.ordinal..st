as yet unclassified
computeStyleNodesFrom: aStyleable stylesheets: aStylesheetList ordinal: anInteger
	| rootNode matchedRules ordinal|
	ordinal := anInteger.
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	aStylesheetList addAll: aStyleable stylesheets.
	aStylesheetList do: [ :eachStylesheet | matchedRules addAll: (eachStylesheet matchingRulesFor: aStyleable) ].
	rootNode := aStyleable styler.
	matchedRules do: [ :r | 
			rootNode styles addAll: 
				((r computedStyles do:[:s| s ordinal: (ordinal := ordinal +1) ]) 
					reject: [ :s | rootNode styles includes: s ]).
			rootNode transitions addAll: 
				((r computedTransitions do:[:s| s ordinal: (ordinal := ordinal +1) ])
					reject: [ :t | rootNode transitions includes: t ]) ].
	aStyleable isParent ifTrue:[
		aStyleable children do: [ :eachChild | 
			rootNode children add: 
				(self computeStyleNodesFrom: eachChild stylesheets: aStylesheetList ordinal:ordinal) ]].
	^ rootNode