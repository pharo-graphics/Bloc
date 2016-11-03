builder
asCollection
	| elements |
	elements := OrderedCollection new.

	self nodes withIndexDo: [ :node :index |
		node hasFloat
			ifTrue: [
				elements ifEmpty: [ elements add: {
					self class floatLeft -> { } asOrderedCollection.
					self class floatRight -> { } asOrderedCollection } asDictionary ].
				(elements last at: node float) add: node asElement ]
			ifFalse: [ elements add: {
				self class floatLeft -> { } asOrderedCollection.
				self class floatNone -> node asElement.
				self class floatRight -> {  } asOrderedCollection } asDictionary ] ].
		
	^ elements