operations
skipBlanksAndComma
	[ stream atEnd not and: [ stream peek isSeparator or: [stream peek =$,]] ] whileTrue: [ stream next ].