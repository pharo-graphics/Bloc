children accessing
findHiddenNonRemovedChildAt: position type: anItemType
	
	^ hiddenChildren
		detect: [ :child |
			| holder |
			holder := controller childHolderOf: child.
			holder layoutPosition = position and: [ holder isInvalid not
				and: [ anItemType = BlInfiniteItemType invalid
					or: [ holder itemType = anItemType ] ] ] ]
		ifNone: [ nil ]