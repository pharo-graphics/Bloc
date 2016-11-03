as yet unclassified
processEvent: aKeyEvent
	|matchingKc|
	
	"no process for repeated key events"
	aKeyEvent repeat = 0 ifFalse:[^ self]. 
	
	matchingKc := OrderedCollection new.
	
	"pending sequences"
	self pendingCombinations 
		do:[:each| (each match: aKeyEvent) ifTrue:[matchingKc add: each combination]].
	self pendingCombinations 
		removeAllSuchThat:[:each| each isTerminated ].
	
	self keyCombinations do: [ :each | 
		(each match: aKeyEvent) 
			"direct match"
			ifTrue:[matchingKc add: each]
			"new matching sequences"
			ifFalse:[(each partiallyMatch: aKeyEvent) 
				ifTrue:[self pendingCombinations add: each asPending]].
		 ].
	
	matchingKc do:[:each| each action value]
	