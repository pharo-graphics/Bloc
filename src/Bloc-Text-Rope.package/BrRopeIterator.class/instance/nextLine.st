accessing
nextLine
	| aSegment |
	
	self hasNext
		ifFalse: [ self error: 'reached end of rope' ].
	
	aSegment := (self isNewLine: self peek) 
		ifTrue: [ self next. BrCollectionRope collection: '' ]
		ifFalse: [ self nextSegment: [ :anItem | self isNewLine: anItem ] ].

	(self hasNext and: [ (self isNewLine: self peek) and: [ self position + 1 < end ]  ])
		ifTrue: [
			self next.
			(self hasNext and: [ (self isNewLine: self peek) ])
				ifTrue: [ self previous ] ].

	^ aSegment