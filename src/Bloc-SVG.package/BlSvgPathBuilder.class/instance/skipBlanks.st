operations
skipBlanks
	[ stream atEnd not and: [ stream peek isSeparator ] ] whileTrue: [ stream next ].