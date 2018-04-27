hooks
onTargetFound: anElement action: aScrollingAction
	| dX dY aDistance aTime |
	
	dX := self calculateDeltaXToMakeVisible: anElement snap: self horizontalSnapPreference.
	dY := self calculateDeltaYToMakeVisible: anElement snap: self verticalSnapPreference.
	aDistance := ((dX * dX) + (dY * dY)) sqrt.
	aTime := self calculateTimeForDeceleration: aDistance.
	aTime <= 0 seconds
		ifTrue: [ ^ self ].
		
	aScrollingAction
		update: (dX @ dY) negated
		duration: aTime
		interpolator: decelerateInterpolator