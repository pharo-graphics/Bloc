iterator - enumeration
next
	| next |
	next := currentIterator next.
	self moveForward.
	^ next