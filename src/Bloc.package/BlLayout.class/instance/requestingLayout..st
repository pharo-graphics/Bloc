protected
requestingLayout: aBoolean
		
	aBoolean
		ifTrue: [ waitingLayout := true ]
		ifFalse: [ waitingLayout
			ifTrue: [ ^ self ] ].

	requestingLayout := aBoolean