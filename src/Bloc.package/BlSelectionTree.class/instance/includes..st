tree - testing
includes: anIndex
	"Return true if this selection interval includes a given index, false otherwise"
	<return: #Boolean>
	
	^ self hasRoot
		ifTrue: [ self root includes: anIndex ]
		ifFalse: [ false ]