heads - geometry
toHeadLength
	"Return a measured length of arrowhead on 'to' side of the path"
	<return: #Number>

	^ self hasToHead
		ifTrue: [ self toHead measuredWidth + self toHead margin width ]
		ifFalse: [ 0.0 ]