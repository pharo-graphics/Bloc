adding/removing
removeFromDisappearedInLayout: anElementHolder
	"Removes an ElementHolder from disappearing list."

	layoutHolderMap
		at: anElementHolder
		ifPresent: [ :aRecord | aRecord clearDisappeared ]