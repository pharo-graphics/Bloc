testing
hasTransformation
	"Return true if my transformation exists and not identity, false otherwise"
	<return: #Boolean>
	
	^ transformation isNotNil
		and: [ transformation isIdentity not ]