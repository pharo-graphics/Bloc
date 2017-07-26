adding
with: aCombination
	
	aCombination isCompulsory
		ifTrue: [ self combinations addAll: aCombination combinations ]
		ifFalse: [ self combinations add: aCombination ]