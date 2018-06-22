accessing
nextLineIndicesDo: anIndicesBlock
	" execute anIndicesBlock with 3 arguments for each line:
		- start index of line
		- end index of line without line delimiter
		- end index of line including line delimiter(s) CR, LF or CRLF"
	| aLineStart aLineEnd aLineEndWithDelimiters aFirstItem |

	self hasNext
		ifFalse: [ self error: 'Reached end of rope' ].

	aLineStart := self position.
	aLineEnd := aLineStart.
	aLineEndWithDelimiters := aLineStart.

	aFirstItem := self peek.

	(self isLineDelimiter: aFirstItem)
		ifTrue: [
			aLineStart := self position - 1.
			aLineEnd := aLineStart.
			aLineEndWithDelimiters := aLineEnd + 1.  ]
		ifFalse: [
			aLineStart := self position.
			self nextSegment: [ :anItem | self isLineDelimiter: anItem ].
			aLineEnd := (self position - 1) max: aLineStart.
			aLineEndWithDelimiters := aLineEnd ].

	self hasNext
		ifTrue: [
			aFirstItem := self peek.
			(self isLineDelimiter: aFirstItem)
				ifTrue: [ 
					self next.
					(self hasNext and: [ (self isCarriageReturn: aFirstItem) and: [ self isLineFeed: self peek ] ])
						ifTrue: [ self next ].
					aLineEndWithDelimiters := self position - 1 ] ].

	anIndicesBlock
		value: aLineStart
		value: aLineEnd
		value: aLineEndWithDelimiters