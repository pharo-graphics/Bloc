accessing
attachChild: anElement at: anIndex
	| anElementHolder |

	anElementHolder := self elementHolderOf: anElement.
	(anElementHolder isTmpDetached not and: [ anElementHolder shouldIgnore not ])
		ifTrue: [ self error: 'Can not attach a child which is not previously detached ' ].
	
	anElementHolder clearTmpDetached.
	infiniteElement attachChild: anElement at: anIndex