testing
isPressed: aKey
	"Return true if a given key is pressed, false otherwise"
	<return: #Boolean>

	^ self hasEvent: aKey