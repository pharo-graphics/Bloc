initialization
updateRectangles: allDamage
	| intersection |
	self validate
		ifFalse: [ ^ self ].
	allDamage do: [ :rectangle | 
		intersection := rectangle intersect: (0 @ 0 corner: hostSpace extent) ifNone: [ nil ].
		intersection ifNotNil: [ 
			"hostSpace hostWindow primGetWindow primInvalidateRect: (GdkRectangle fromRect: intersection) autoRelease"
			hostSpace hostWindow primGetWindow queueDrawArea: intersection
		] 
	]