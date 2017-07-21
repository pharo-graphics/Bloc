events-processing
matchingShortcut: anEventBuffer

	"pending shortcuts have priority"
	self pendingShortcuts do: [ :each | 
			(each match: eventBuffer) ifTrue: [ ^ each shortcut ] ].
	"remove pending shortcuts which have failed"
	self pendingShortcuts removeAllSuchThat: [ :each | each isTerminated ].
	
	self shortcuts do: [ :each | 
			(each match: eventBuffer)
				"direct match" 
				ifTrue: [  ^ each ]
				"partial match"
				ifFalse: [ (each partiallyMatch: eventBuffer)
						ifTrue: [ self pendingShortcuts add: each asPending ] ]
			].
	
	self pendingShortcuts ifEmpty: [ eventBuffer clear ].
	^ nil