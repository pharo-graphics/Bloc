comparing
= aCombinationSequence
	self class = aCombinationSequence class ifFalse: [ ^ false ].
	^ self sequence includesAll: aCombinationSequence sequence