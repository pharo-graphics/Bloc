protected
measureChildWithMargins: anElement parentSpec: parentSpec widthUsed: widthUsed heightUsed: heightUsed
	"Measure anElement based on provided parent's extent measurement specification and used width and height
	taking element's margin and parent's padding into account"
	
	self
		measureChild: anElement
		parentSpec: parentSpec
		widthUsed: anElement parent insets width + anElement outsets width + widthUsed
		heightUsed: anElement parent insets height + anElement outsets height + heightUsed