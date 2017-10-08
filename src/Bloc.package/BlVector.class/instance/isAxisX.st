testing
isAxisX
	"Return true if I represent a vector along x axis without y and z components"
	<return: #Boolean>
	
	^ self hasComponentX and: [ self hasComponentY not and: [ self hasComponentZ not ] ]