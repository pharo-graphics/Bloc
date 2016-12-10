geometry
paddingStart
	"Returns the padding at the beginning of the layout.
	For horizontal orientation, this is the left padding and for vertical, this is the top padding.
	Note: I do not check whether the layout is RTL or not"
	<return: #Number>
	
	^ self subclassResponsibility