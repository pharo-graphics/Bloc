accessing
nextLine

	"The last item is carriage return, we don't want it to be a new line"
	(self position = end and: [
		(self isNewLine: self peek) ])
			ifTrue: [
				"Move iterator to the next, to make sure that hasNext returns false"
				self next.
				^ BrCollectionRope collection: #() ].
	^ self nextSegment: [ :item | self isNewLine: item ]