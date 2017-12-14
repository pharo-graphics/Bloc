testing
hasCursor
	"Return true if cursor exists and visible"
	<return: #Boolean>

	^ self cursorExists and: [ cursorElement hasParent ]