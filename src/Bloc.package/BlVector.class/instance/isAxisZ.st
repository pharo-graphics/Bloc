testing
isAxisZ
	"Return true if I represent a vector along z axis without x and y components"
	<return: #Boolean>
	
	^ self hasComponentZ and: [ self hasComponentX not and: [ self hasComponentY not ] ]