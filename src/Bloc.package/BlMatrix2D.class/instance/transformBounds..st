matrix - transforming points
transformBounds: aBlBounds
	"In-place transform given BlBounds according to my transformation.
	(local to global transformation)"
	<return: #BlBounds>
	| newLeft newTop newRight newBottom quadTopLeft quadTopRight quadBottomLeft quadBottomRight |

	self isIdentity
		ifTrue: [ ^ aBlBounds ].

	quadTopLeft := self transformX: aBlBounds left Y: aBlBounds top.
	quadTopRight := self transformX: aBlBounds right Y: aBlBounds top.
	quadBottomLeft := self transformX: aBlBounds left Y: aBlBounds bottom.
	quadBottomRight := self transformX: aBlBounds right Y: aBlBounds bottom.

	newLeft := ((quadTopLeft x
		min: quadTopRight x)
			min: quadBottomLeft x)
				min: quadBottomRight x.
	newRight := ((quadTopLeft x
		max: quadTopRight x)
			max: quadBottomLeft x)
				max: quadBottomRight x.

	newTop := ((quadTopLeft y
		min: quadTopRight y)
			min: quadBottomLeft y)
				min: quadBottomRight y.
				
	newBottom := ((quadTopLeft y
		max: quadTopRight y)
			max: quadBottomLeft y)
				max: quadBottomRight y.
	
	aBlBounds
		left: newLeft
		top: newTop
		right: newRight
		bottom: newBottom.
		
	^ aBlBounds