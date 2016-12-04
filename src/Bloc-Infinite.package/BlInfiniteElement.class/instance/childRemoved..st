children - add/remove hooks
childRemoved: anElement
	
	(self elementHolderOf:anElement)
		ifNotNil: [ :holder |
			holder isTmpDetached
				ifTrue: [ holder clearTmpDetach ]
				ifFalse: [ holder shouldIgnore
					ifFalse: [ Error signal: 'Can not remove child which is not flagged at temporary detached!' ] ].

		"Notify data source that child was removed"
		self dataSource onElementRemoved: holder ]