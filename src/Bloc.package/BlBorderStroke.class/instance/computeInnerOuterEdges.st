private
computeInnerOuterEdges
	| inside outside |
	self style type = BlStrokeType OUTSIDE
		ifTrue: [ outside := self width.
			inside := 0 ].
	self style type = BlStrokeType CENTERED
		ifTrue: [ outside := inside := self width / 2.0 ].
	self style type = BlStrokeType INSIDE
		ifTrue: [ outside := 0.
			inside := self width ].
	innerEdge := BlInsets all: inside.
	outerEdge := BlInsets all: outside