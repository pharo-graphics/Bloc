children accessing
findHiddenNonRemovedChildAt: aPosition type: anItemType
	"Return a disappearing child by position.
	Returns nil if child not found"
	<return: #BlElement or: nil>

	^ hiddenChildren
		detect: [ :child |
			| holder |
			holder := controller childHolderOf: child.
			holder layoutPosition = aPosition
				and: [ holder isInvalid not
					and: [ holder isRemoved not
						and: [ anItemType = BlInfiniteItemType invalid
							or: [ holder itemType = anItemType ] ] ] ] ]
		ifNone: [ nil ]