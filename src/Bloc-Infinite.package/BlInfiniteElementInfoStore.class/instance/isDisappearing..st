testing
isDisappearing: anElementHolder
	"Return true if the given ElementHolder is in disappearing list, false otherwise"
	<return: #Boolean>
	
	^ layoutHolderMap
		at: anElementHolder
		ifPresent: [ :aRecord | aRecord flags hasDisappeared ]
		ifAbsent: [ false ]