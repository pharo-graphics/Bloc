instance creation
createHolder: anInfiniteElement type: anItemType
	| anElementHolder |
	anElementHolder := self onCreateHolder: anInfiniteElement type: anItemType.
	anElementHolder itemType: anItemType.
	^ anElementHolder