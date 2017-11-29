heads - geometry
toHeadBreadth
	"Return a measured breadth of arrowhead on 'to' side of the path"
	<return: #Number>

	^ self hasToHead
		ifTrue: [ self toHead measuredHeight ]
		ifFalse: [ 0.0 ]