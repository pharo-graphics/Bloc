recycling
recycleElement: anElement
	"Recycle a detached element.
	The specified element will be added to a pool of elements for later rebinding and reuse.
	An element must be fully detached (removed from parent) before it may be recycled.
	If the element is scrapped, it will be removed from scrap list

	Notice: I try to make element recycle-able since layout intended to recycle this element (e.g. even if it is in scrap or change cache)"
	| anElementHolder |
	
	anElementHolder := self controller elementHolderOf: anElement.
	anElementHolder isTmpDetached
		ifTrue: [ self controller removeDetachedChild: anElement ].
	
	anElementHolder isScrap
		ifTrue: [ anElementHolder unscrap ]
		ifFalse: [ anElementHolder wasReturnedFromScrap
			ifTrue: [ anElementHolder clearReturnedFromScrap ] ].
	
	self recycleElementHolder: anElementHolder