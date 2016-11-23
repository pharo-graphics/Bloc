children add/remove
moveChildFrom: aFromIndex to: aToIndex
	"Moves a child element from one position to another"
	| anElement |
	
	anElement := self childAt: aFromIndex.
	self
		assert: [ anElement isNotNil ]
		description: [ 'Can not move a child from non-existing index' ].
	
	self detachChildAt: aFromIndex.
	self attachChild: anElement at: aToIndex