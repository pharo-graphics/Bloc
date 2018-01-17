drag and drop
drag: aDragItemOrItems from: aSourceElement
	"Add provided drag items (or a single item) with a given element as its source to this drag session"
	
	dragRegistry at: aSourceElement put: aDragItemOrItems asOrderedCollection