comparing
= anObject
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ vertical = anObject vertical
		and: [ horizontal = anObject horizontal
			and: [ margin = anObject margin
				and: [ padding = anObject padding
					and: [ minHeight = anObject minHeight
						and: [ minWidth = anObject minWidth
							and: [ visibility = anObject visibility ] ] ] ] ] ]