tree - testing
contains: anIndex
	"Return true if this selection interval includes a given index, false otherwise"
	<return: #Boolean>
	
	^ self hasRoot
		ifTrue: [ self root contains: anIndex ]
		ifFalse: [ false ]