testing
= anObject
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ left = anObject left
		and: [ right = anObject right
			and: [ top = anObject top
				and: [ bottom = anObject bottom ] ] ]