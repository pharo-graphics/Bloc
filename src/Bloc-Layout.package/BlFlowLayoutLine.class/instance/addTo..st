adding
addTo: theLines
	"I dispatch to concreate addFirst/addLast based on layout configuration"
	(self orientation isVertical and: [ self direction isRightToLeft ])
		ifTrue: [ theLines addFirst: self ]
		ifFalse: [ theLines addLast: self ].
	index := theLines size