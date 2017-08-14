protected
requestingLayout: aBoolean
		
	aBoolean
		ifTrue: [ waitingLayout := true ]
		ifFalse: [ self waitingLayout
			ifTrue: [ ^ self ] ].

	requestingLayout := aBoolean