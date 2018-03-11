children accessing
childNamed: aContainerName ifFound: ifFoundBlock ifNone: ifNoneBlock

	self allChildrenBreadthFirstDo: [ :aChild |
		aChild userData
			at: #blocContainer
			ifPresent: [ :aName | (aName = aContainerName)
				ifTrue: [
					ifFoundBlock value: aChild.
					^ self ] ] ].
	ifNoneBlock value