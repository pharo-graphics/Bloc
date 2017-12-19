measure
boundingBox: anElement
	<return: #Rectangle>
	| aBoundingBox |

	anElement children isEmpty
		ifTrue: [ ^ BlBounds new asRectangle ].

	aBoundingBox := nil.
	self
		layeredChildren: anElement
		do: [ :aChild |
			aBoundingBox
				ifNil: [ aBoundingBox := BlBounds fromRectangle: aChild measuredBounds bounds ]
				ifNotNil: [ aBoundingBox merge: aChild measuredBounds bounds ] ].

	^ aBoundingBox expanded asRectangle