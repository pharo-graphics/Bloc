converting
asDictionary
	| index lastPriority |
	index := 0.
	lastPriority := nil.
	
	^ (nodes collect: [ :node | 
			| key |
			key := node priority asString.
			node priority = lastPriority
				ifTrue: [
					index := index + 1.
					key := '[', index asString, '] ', key ]
				ifFalse: [ 
					lastPriority := node priority.
					index := 0 ].
			key -> node value	 ]) asOrderedDictionary