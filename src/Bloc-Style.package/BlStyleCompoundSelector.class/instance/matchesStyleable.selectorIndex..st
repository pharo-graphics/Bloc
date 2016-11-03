testing
matchesStyleable: aStyleable selectorIndex: aSelectorIndex
	^ self
		matchesStyleable: aStyleable
		pseudoClassStates: OrderedCollection new
		selectorIndex: aSelectorIndex