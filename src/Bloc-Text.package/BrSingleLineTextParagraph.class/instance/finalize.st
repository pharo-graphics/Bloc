finalization
finalize

	spans ifNotNil: [ :theSpans |
		theSpans do: [ :aSpan | aSpan finalize ] ].
	spans := nil