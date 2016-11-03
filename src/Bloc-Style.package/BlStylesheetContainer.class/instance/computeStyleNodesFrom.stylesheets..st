as yet unclassified
computeStyleNodesFrom: aStyleable stylesheets: aStylesheetList
	| rootNode matchedRules |
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	aStylesheetList addAll: aStyleable stylesheets.
	aStylesheetList do: [ :eachStylesheet | matchedRules addAll: (eachStylesheet matchingRulesFor: aStyleable) ].
	rootNode := aStyleable styler.
	matchedRules do: [ :r | 
			rootNode styles addAll: (r computedStyles reject: [ :s | rootNode styles includes: s ]).
			rootNode transitions addAll: (r computedTransitions reject: [ :t | rootNode transitions includes: t ]) ].
	aStyleable isParent ifTrue:[
		aStyleable children do: [ :eachChild | rootNode children add: (self computeStyleNodesFrom: eachChild stylesheets: aStylesheetList) ]].
	^ rootNode