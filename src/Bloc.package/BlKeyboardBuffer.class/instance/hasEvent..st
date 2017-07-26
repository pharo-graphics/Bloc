testing
hasEvent: aKey
	"Return true if there is a buffered event for a given key"
	<return: #Boolean>
	
	^ events includesKey: aKey