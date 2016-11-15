manager -> element
childIndexOf: aChildElement
	"Return an index of aChildElement within children collection
	of infinite element or 0 if child is not a direct child of
	infinite element.
	aChildElement must not be nil.
	aChildElement must not be nil"
	<return: #Number>
	
	^ self subclassResponsibility