accessing
nextWord

	"The last item is space, we don't want it to be a new word"
	(self position = end and: [
		self peek = Character space ])
			ifTrue: [
				"Move iterator to the next, to make sure that hasNext returns false"
				self next.
				^ BrCollectionRope collection: #() ].
	^ self nextSegmentIncluding: [ :item | item = Character space ]