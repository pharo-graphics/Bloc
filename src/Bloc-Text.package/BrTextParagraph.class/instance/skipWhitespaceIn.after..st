testing
skipWhitespaceIn: aString after: aStart
	"Return an index of the first non-whitespace character in aString after aStart index"
	<return: #Number>
	| anIndex aChar |

	anIndex := aStart.
	aChar := aString at: anIndex.
	[ anIndex < aString size
		and: [ self isWhitespace: aChar ] ]
			whileTrue: [ 
				anIndex := anIndex + 1.
				aChar := aString at: anIndex ].
	^ anIndex