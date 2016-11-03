private utilities
clip: range isDefined: isDefined count: count
	"We treat range Interval as open: start <= x < end"
	| size min |
	size := range size - 1.
	count = 0
		ifTrue: [ ^ size ].

	min := isDefined
		ifTrue: [ (range first min: count) - 1 ]
		ifFalse: [ 0 ].

	^ size min: count - min