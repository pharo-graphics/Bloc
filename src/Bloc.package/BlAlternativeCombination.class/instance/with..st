adding
with: aCombination
	aCombination isAlternative
		ifTrue: [ self combinations addAll: aCombination combinations ]
		ifFalse: [ self combinations add: aCombination ]