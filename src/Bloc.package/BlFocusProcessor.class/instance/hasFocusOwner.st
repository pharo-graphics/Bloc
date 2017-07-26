testing
hasFocusOwner
	"Return true if there is an element holding focus, false otherwise.
	When there are no elements interested in focus it is given to the root element.
	Note: focus owner may not exist during space initialization or inbetween blur and focus events"
	<return: #Boolean>
	
	^ focusOwner isNotNil