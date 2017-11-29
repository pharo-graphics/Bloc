heads - geometry
fromHeadBreadth
	"Return a measured breadth of arrowhead on 'from' side of the path"
	<return: #Number>

	^ self hasFromHead
		ifTrue: [ self fromHead measuredHeight ]
		ifFalse: [ 0.0 ]