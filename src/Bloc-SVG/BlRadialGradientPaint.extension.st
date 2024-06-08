Extension { #name : #BlRadialGradientPaint }

{ #category : #'*Bloc-SVG' }
BlRadialGradientPaint >> adaptedToElement: aBlElement [
	"Sets the instance variables to match the BlElement size"

	aBlElement whenLayoutedDoOnce: [
		| corner |
		corner := aBlElement size.		
		self innerCenter: corner * (self innerCenter / 100) asFloatPoint.
		self outerCenter: corner * (self outerCenter / 100) asFloatPoint.
		self innerRadius: 0.
		self outerRadius:
			(corner distanceTo: 0 @ 0) * (self outerRadius / 100) asFloat ]
]
