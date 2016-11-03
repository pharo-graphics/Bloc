as yet unclassified
match: aKeyEvent
	self seqSize > 1 ifTrue:[^ false].
	^ self partiallyMatch: aKeyEvent