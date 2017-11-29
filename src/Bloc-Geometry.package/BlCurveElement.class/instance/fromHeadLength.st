heads - geometry
fromHeadLength
	"Return a measured length of arrowhead on 'from' side of the path"
	<return: #Number>

	^ self hasFromHead
		ifTrue: [ self fromHead measuredWidth + self fromHead margin width ]
		ifFalse: [ 0.0 ]