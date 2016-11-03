protected
measureChildWithMargins: anElement parentSpec: parentSpec
	"Measure anElement based on provided parent's extent measurement specification
	taking element's margin and parent's padding into account"
	
	self
		measureChildWithMargins: anElement
		parentSpec: parentSpec
		widthUsed: 0
		heightUsed: 0