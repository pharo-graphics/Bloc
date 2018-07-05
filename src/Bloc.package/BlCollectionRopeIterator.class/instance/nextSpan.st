iterator - enumeration
nextSpan
	| run |
	run := rope from: (position max: 1) to: end.
	position := end + 1.
	^ run