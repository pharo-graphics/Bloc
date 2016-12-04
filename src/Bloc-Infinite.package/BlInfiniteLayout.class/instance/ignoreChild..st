children - state
ignoreChild: anElement
	"Flags an element so that it will not be scrapped or recycled"
	| anElementHolder |
	
	(anElement parent ~~ infiniteElement
		or: [ (infiniteElement childIndexOf: anElement) = 0 ])
			ifTrue: [ self error: 'Not attached element can not be ignored' ].
	
	anElementHolder := self elementHolderOf: anElement.
	anElementHolder flags addIgnore.
	self infoRemoveHolder: anElementHolder