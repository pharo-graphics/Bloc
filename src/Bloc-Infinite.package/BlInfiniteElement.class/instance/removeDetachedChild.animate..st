children - add/remove
removeDetachedChild: anElement animate: shouldAnimate
	| anElementHolder |
	
	anElementHolder := self elementHolderOf: anElement.
	
	anElementHolder isTmpDetached
		ifTrue: [ anElementHolder clearTmpDetached ]
		ifFalse: [ anElementHolder shouldIgnore
			ifFalse: [ self error: 'Trying to removeDetachedChild: which is not flagged as temporary detached!' ] ].
	
	self dispatchChildDetached: anElement.
	self removeDetachedChild: anElement