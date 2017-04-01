manager -> element
elementHolderAt: aPosition
	<return: #BlElement or: nil>

	^ (infiniteElement findElementHolderForPosition: aPosition checkNew: true)
		ifNotNil: [ :anElementHolder |
			"ensure it is not hidden because for datasource manager,
			the only thing matter is that layout thinks element is a child"
			(infiniteElement childrenManager isHidden: anElementHolder itemElement)
				ifTrue: [ nil ]
				ifFalse: [ anElementHolder ] ]