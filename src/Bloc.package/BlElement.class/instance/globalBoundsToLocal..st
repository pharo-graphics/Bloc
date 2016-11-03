geometry bounds convertion
globalBoundsToLocal: aRectangle
	| r |
	r := self parent
		ifNil: [ transform globalBoundsToLocal: aRectangle ]
		ifNotNil: [ :p | p globalBoundsToLocal: (transform globalBoundsToLocal: aRectangle) ].
	^ r translateBy: self position negated