testing
isAxisY
	"Return true if I represent a vector along y axis without x and z components"
	<return: #Boolean>
	
	^ self hasComponentY and: [ self hasComponentX not and: [ self hasComponentZ not ] ]