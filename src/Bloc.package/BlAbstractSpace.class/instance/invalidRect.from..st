change reporting
invalidRect: aDirtyRect from: aNode
	| aDamagedArea |
	
	"detecting damaged area involves many rectangle operations,
	so it is better to work with mutable rectangle and modify
	it in-place without rectangle instantioations over and over again"
	aDamagedArea := SpartaRectangle fromRectangle: aDirtyRect.
	aDamagedArea expanded.

	"if rect is already contained in an existing dirty area, do nothing"
	self dirtyAreas
		findBinaryIndex: [ :each | (aDamagedArea containedInRect: each)
			ifTrue: [ 0 ]
			ifFalse: [ (aDamagedArea left < each left and: [ aDamagedArea top < each top ])
				ifTrue: [ -1 ]
				ifFalse: [ 1 ] ] ]
		do: [ :found | ^ self ]
		ifNone: [ :a :b |  ].

	"We remove elements in block, so have to iterate in reversed order"
	self dirtyAreas reverseDo: [ :each |
		(aDamagedArea intersects: each)
			ifTrue: [ 
				self dirtyAreas remove: each.
				"in-place grow our damage area"
				aDamagedArea merge: each ] ].

	self dirtyAreas add: aDamagedArea asRectangle.
	self requestNextPulse