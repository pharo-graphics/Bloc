iterator - enumeration
nextSpan
	| run theAttributes |
	
	theAttributes := self rope attributes.
	run := subIterator nextSpan. "span without my rope's attributes"
	run == rope rope
		ifTrue: [ ^ rope ].

	^ run attributes: theAttributes from: 1 to: run size