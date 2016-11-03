geometry position convertion
globalPointToLocal: aPoint
	| pt |
	pt := self parent
		ifNil: [ self transform inverseTransform: aPoint ]
		ifNotNil: [ :p | p globalPointToLocal: (self transform inverseTransform: aPoint) ].
	^ pt translateBy: self position negated