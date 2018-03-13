children add/remove
addChild: anElement as: aContainerName
	"Add a given element to my children and make it a named container, so that
	we could add children in that container"
	
	self
		assert: [ (self children
			detect: [ :aChild |
				aChild userData
					at: #blocContainer
					ifPresent: [ :aName | aName = aContainerName ]
					ifAbsent: [ false ] ]
			ifFound: [ true ]
			ifNone: [ false ]) not ]
		description: [ 'Child named #', aContainerName asString, ' already exists' ].
	
	anElement userData at: #blocContainer put: aContainerName.
	self addChild: anElement