tree - testing
contains: anIndex
	"Return true if this selection interval includes a given index, false otherwise"
	<return: #Boolean>

	anIndex > self high
		ifTrue: [ ^ false ].
		
	(self selection contains: anIndex)
		ifTrue: [ ^ true ].
		
	(self hasLeft and: [ anIndex <= self left high ])
		ifTrue: [ ^ self left contains: anIndex ].
		
	(self hasRight and: [ anIndex <= self right high ])
		ifTrue: [ ^ self right contains: anIndex ].
		
	^ false