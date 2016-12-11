children - accessing
findElementHolderForPosition: aPosition checkNew: shouldCheckNewPosition
	<return: #BlElement or: nil>
	| aHiddenElement |
	
	aHiddenElement := nil.
	
	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder isRemoved
			ifFalse: [ 
				| shouldSkip |
				shouldSkip := shouldCheckNewPosition
					ifTrue: [ anElementHolder position ~= aPosition ]
					ifFalse: [ anElementHolder layoutPosition ~= aPosition ].
				shouldSkip
					ifFalse: [ 
						(childrenManager isHidden: anElementHolder itemElement)
							ifTrue: [ aHiddenElement := anElementHolder ]
							ifFalse: [ ^ anElementHolder ] ]	] ].
	
	"We should not query cached element. It creates a problem during data source updates
	when we are dealing with already laid out elements. Also, for the public use, it is more
	reasonable to return null if position is not laid out"
	^ aHiddenElement