initialization
computeZoomLevel
	"Compute zoom level based on the extent of a content element and its scale transformation"
	<return: #Number>

	self hasContentElement
		ifFalse: [ ^ 1 ].

	(self contentElement width isZero or: [ self contentElement height isZero ])
		ifTrue: [ ^ 1 ].

	^ (self contentElement bounds transformed extent / self contentElement extent) min