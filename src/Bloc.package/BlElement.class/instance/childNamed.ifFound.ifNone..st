children accessing
childNamed: aContainerName ifFound: ifFoundBlock ifNone: ifNoneBlock
	<return: #Object>

	self allChildrenBreadthFirstDo: [ :aChild |
		aChild userData
			at: #blocContainer
			ifPresent: [ :aName | (aName = aContainerName)
				ifTrue: [ ^ ifFoundBlock value: aChild ] ] ].
	^ ifNoneBlock value