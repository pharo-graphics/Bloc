rope - accessing
empty
	"Create and return an empty version of this rope"
	<return: #BlRope>
	
	^ self class
		attributes: self attributes
		rope: self rope empty