testing
isTranslucent
	"Return true if I am semi-transparent (opacity is 0 < opacity < 1)"
	<return: #Boolean>

	^ self opacity > 0 and: [ self opacity < 1 ]