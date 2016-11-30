testing
isInPreLayout: anElementHolder
	"Return true if the given ElementHolder is in preLayout list, false otherwise"
	<return: #Boolean>
	
	^ layoutHolderMap
		at: anElementHolder
		ifPresent: [ :aRecord | aRecord flags hasPre ]
		ifAbsent: [ false ]