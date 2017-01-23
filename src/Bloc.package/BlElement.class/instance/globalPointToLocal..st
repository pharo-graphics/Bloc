geometry position convertion
globalPointToLocal: aPoint
	| pt |
	pt := self parent
		ifNil: [ self transform inverseTransformPoint: aPoint ]
		ifNotNil: [ :p | p globalPointToLocal: (self transform inverseTransformPoint: aPoint) ].
	^ pt translateBy: self position negated