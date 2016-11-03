write and read
readInteger
	| result |
	(stream atEnd or: [ stream peek isDigit not ]) ifTrue: [ ^ nil ].
	
	result := 0.
	[ stream peek notNil and: [ stream peek isDigit ] ] whileTrue: [
		result := result * 10 + (stream next digitValue)
	].
	^ result