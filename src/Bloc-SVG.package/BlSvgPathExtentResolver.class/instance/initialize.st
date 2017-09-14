initialization
initialize
	super initialize.
	relative := false.
	previousPoint := 0@0.
	minPoint := SmallInteger maxVal asPoint.
	maxPoint := SmallInteger minVal asPoint.