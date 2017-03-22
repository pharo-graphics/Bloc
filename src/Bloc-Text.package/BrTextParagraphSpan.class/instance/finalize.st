finalization
finalize

	textRun ifNotNil: [ :aTextRun | aTextRun release ].
	textRun := nil