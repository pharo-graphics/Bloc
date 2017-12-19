measure
normalize: anElement in: aRectangle
	| boundingBox delta |

	boundingBox := self boundingBox: anElement.
	delta := ((aRectangle extent / 2.0) - boundingBox center).
	"bounding box depends on element positions, while position themselves depend on bounding box.
	That is why we have to implement a cycle breaking mechanism. In our case it makes sense to
	to not relocate children if delta is less then 1 point"
	delta abs < (1@1)
		ifTrue: [ ^ self ].

	self
		layeredChildren: anElement
		do: [ :aChild | aChild measuredBounds position: aChild measuredBounds position + delta ]