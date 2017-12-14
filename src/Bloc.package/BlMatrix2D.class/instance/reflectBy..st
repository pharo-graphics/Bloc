matrix - transformations
reflectBy: aDiagonalVector
	"Apply a reflection transformation given by a diagonal vector"
		
	"Apply the reflection AFTER my existing transformation."
	self multiplyBy: (self class reflection: aDiagonalVector)