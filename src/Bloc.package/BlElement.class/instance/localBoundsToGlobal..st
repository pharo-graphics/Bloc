geometry bounds convertion
localBoundsToGlobal: aRectangle
	| r |
	r := self parent
		ifNil: [  transform localBoundsToGlobal: aRectangle ]
		ifNotNil: [ :p | p localBoundsToGlobal: (transform localBoundsToGlobal: aRectangle) ].
	^ r translateBy: self position