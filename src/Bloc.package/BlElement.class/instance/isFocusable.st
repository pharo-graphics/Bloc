focus testing
isFocusable
	"Return true if I am able to take focus, false otherwise"
	<return: #Boolean>

	^ self isVisible and: [ self wantsMouse ]