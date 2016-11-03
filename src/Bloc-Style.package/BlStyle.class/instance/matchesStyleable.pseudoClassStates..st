testing
matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList
	self conditions
		ifNotNil: [ :cs | 
			 cs do: [ :c | 
					(c isValidOn: aStyleable) ifFalse: [ ^ false ] ] ].
			
	^ self selector matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList