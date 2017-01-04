accessing
reset
	Default ifNotNil: [
		[
		Default spaceManager spaces do: [ :aSpace | aSpace close ].
		Default isRunning ifTrue: [ Default stop ] ]
			"This is hard reset, so we have to ignore all errors, just print them"
			on: Error do: [ :e | e logCr ] ].
	Default := nil