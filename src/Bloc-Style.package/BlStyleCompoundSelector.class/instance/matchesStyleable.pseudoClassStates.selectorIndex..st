testing
matchesStyleable: aNode pseudoClassStates: aPseudoClassStateList selectorIndex: aSelectorIndex
	| selector parent relation |
	aSelectorIndex = 0
		ifTrue: [ ^ true ].	"no more selectors, so it matches"
	selector := selectors at: aSelectorIndex.
	(selector matchesStyleable: aNode pseudoClassStates: aPseudoClassStateList selectorIndex: aSelectorIndex)
		ifFalse: [ ^ false ].
	aSelectorIndex = 1
		ifTrue: [ ^ true ].	"no more selectors, so it matches"
	relation := relationships at: aSelectorIndex - 1.
	parent := aNode parent.
	relation isChild
		ifTrue: [ ^ self matchesStyleable: parent pseudoClassStates: aPseudoClassStateList allButLast selectorIndex: aSelectorIndex - 1 ].
	relation isDescendant
		ifTrue:
			[ | thePseudoClassStateList |
			thePseudoClassStateList := aPseudoClassStateList.
			[ parent isNotNil ]
				whileTrue:
					[ thePseudoClassStateList := thePseudoClassStateList allButLast.
					(self matchesStyleable: parent pseudoClassStates: thePseudoClassStateList selectorIndex: aSelectorIndex - 1)
						ifTrue: [ ^ true ].
					parent := parent parent ] ].
	^ false