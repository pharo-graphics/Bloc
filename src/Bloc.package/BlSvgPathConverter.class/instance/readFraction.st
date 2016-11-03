operations
readFraction
"
read fraction, what is after the decimal point:

.12345


"
	| result mul |
	(stream atEnd or: [ stream peek isDigit not ]) ifTrue: [ ^ nil ].
	
	mul := 1/10. 
	result := 0.
	[ stream peek notNil and: [ stream peek isDigit ] ] whileTrue: [
		result := result + ( (stream next digitValue) * mul ).
		mul := mul / 10
	].
	^ result