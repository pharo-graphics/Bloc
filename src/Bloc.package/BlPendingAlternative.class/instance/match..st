accessing
match: aKeyEvent
	(pendingAlternatives anySatisfy:[:each| each match: aKeyEvent])
		ifTrue: [terminated := true. ^ true].
	
	(pendingAlternatives allSatisfy:[:each| each isTerminated ])
		ifTrue:[terminated := true].
		
	^ false