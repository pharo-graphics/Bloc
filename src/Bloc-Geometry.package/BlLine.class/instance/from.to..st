initialization
from: aFromPoint to: aToPoint

	(from = aFromPoint and: [ to = aToPoint ])
		ifFalse: [ self releaseCache ].

	from := aFromPoint.
	to := aToPoint