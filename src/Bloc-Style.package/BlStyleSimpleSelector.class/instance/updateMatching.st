updating
updateMatching
	matchOnId := id isNotNil and: [ id isNotEmpty ].
	matchOnName := name isNotNil and: [ name isNotEmpty and: [ (name = '*') not ] ].
	matchOnStyleClass := styleClasses isNotEmpty.