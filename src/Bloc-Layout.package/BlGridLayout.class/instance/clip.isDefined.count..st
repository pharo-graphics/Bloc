private utilities
clip: range isDefined: isDefined count: count
	| size min |
	size := range size - 1.
	count = 0
		ifTrue: [ ^ size ].

	min := isDefined
		ifTrue: [ (range first - 1) min: count ]
		ifFalse: [ 0 ].

	^ size min: count - min