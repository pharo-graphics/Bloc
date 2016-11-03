geometry extent
highestLineWidth
	|maxWidth current end |
	current := self layoutView text startPosition.
	end := self layoutView text endPosition.
	maxWidth := 0.
	[ current < end ] whileTrue: [ |width line|
		line := self layoutView layoutStrategy scanSingleVisualLineFor: self layoutView layoutView startingAt: current.
		width := line width.
		current := line endPosition + 1.
		maxWidth := maxWidth max: width ].
	^ maxWidth