comparing
= anotherObject

	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].

	^ anotherObject isAbsolute = self isAbsolute
		and: [ anotherObject curveTo = self curveTo
			and: [ anotherObject firstViaPoint = self firstViaPoint
				and: [ anotherObject secondViaPoint = self secondViaPoint ] ] ]