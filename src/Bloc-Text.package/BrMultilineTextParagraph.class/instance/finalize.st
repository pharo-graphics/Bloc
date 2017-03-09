finalization
finalize

	lines ifNotNil: [ :theLines |
		theLines do: [ :aLine | aLine finalize ] ].
	lines := nil