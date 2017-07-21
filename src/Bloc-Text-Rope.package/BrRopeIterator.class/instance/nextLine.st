accessing
nextLine
	| aSegment |
	
	self hasNext
		ifFalse: [ self error: 'reached end of rope' ].
	
	(self isNewLine: self peek) ifTrue: [
		self hasNext ifTrue: [ self next ].
		^ BrCollectionRope collection: '' ].
	
	aSegment := self nextSegment: [ :anItem | self isNewLine: anItem ].

	(self hasNext and: [ (self isNewLine: self peek) and: [ self position + 1 < self rope size ] ])
		ifTrue: [ self next ].
		
	^ aSegment