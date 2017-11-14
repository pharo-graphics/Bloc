children accessing
hasParent: anElement
	"Return true if I have a given element in my parent chain, false otherwise"
	<return: #Boolean>

	self parentsDo: [ :aParentElement |
		aParentElement == anElement
			ifTrue: [ ^ true ] ].

	^ false