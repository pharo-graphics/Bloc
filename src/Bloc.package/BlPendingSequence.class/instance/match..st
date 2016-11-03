accessing
match: aKeyEvent
	"no match, end of the pending sequence"
	((combination at: index) match: aKeyEvent)
		ifFalse: [terminated := true. ^ false].
	"complete match"
	index = combination seqSize ifTrue:[terminated := true. ^ true].
	"partial match"
	index := index + 1.
	^ false 