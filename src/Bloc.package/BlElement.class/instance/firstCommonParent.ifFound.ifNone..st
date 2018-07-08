children accessing
firstCommonParent: anElement ifFound: aFoundBlock ifNone: aNoneBlock
	"Find the first common parent of a receiver and a given element.
	Evaluate aFoundBlock with that parent if there is one and aNoneBlock otherwise"
	
	self withParentsDo: [ :myParent |
		anElement withParentsDo: [ :otherParent |
			myParent == otherParent
				ifTrue: [ ^ aFoundBlock value: myParent ] ] ].
	
	^ aNoneBlock value