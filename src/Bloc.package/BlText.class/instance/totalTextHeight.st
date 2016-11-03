geometry extent
totalTextHeight
	|height current end |
	current := self layoutView text startPosition.
	end := self layoutView text endPosition.
	height := 0.
	[ current < end ] whileTrue: [ |line|
		line := self layoutView layoutStrategy scanSingleVisualLineFor: self layoutView layoutView startingAt: current.
		current := line endPosition + 1.
		height := height + line height ].
	^ height