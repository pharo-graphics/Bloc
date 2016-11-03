geometry position convertion
localPointToGlobal: aPoint
	| pt |
	pt := self parent
		ifNil: [ self transform transform: aPoint ]
		ifNotNil: [ :p | p localPointToGlobal: (self transform transform: aPoint) ].
	^ pt translateBy: self position