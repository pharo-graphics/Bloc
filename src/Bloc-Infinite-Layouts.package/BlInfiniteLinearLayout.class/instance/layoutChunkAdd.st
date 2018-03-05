layout
layoutChunkAdd
	<return: #BlElement>
	| anElement |

	anElement := layoutState nextElement: self recycler.
	self
		assert: [ anElement isNotNil ]
		description: [ 'Next element can not be nil if we have items to display' ].
	
	layoutState hasScrapList
		ifFalse: [ (shouldReverseLayout = layoutState isLayoutStartDirection)
			"add child as last"
			ifTrue: [ self addChild: anElement ]
			"add child as first"
			ifFalse: [ self addChild: anElement at: 1 ] ]
		ifTrue: [ (shouldReverseLayout = layoutState isLayoutStartDirection)
			"add child as last"
			ifTrue: [ self addDisappearingChild: anElement ]
			"add child as first"
			ifFalse: [ self addDisappearingChild: anElement at: 1 ] ].
	self notifyChunkAdded: anElement.
	
	^ anElement