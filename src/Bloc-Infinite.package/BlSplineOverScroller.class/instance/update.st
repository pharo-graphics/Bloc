scrolling
update
	| aTime aDeltaTime aDistance|

	aTime := DateAndTime millisecondClockValue.
	aDeltaTime := aTime - startTime.
	
	"almost zero"
	(aDeltaTime abs < 0.0001)
		"Skip work but report that we're still going if we have a nonzero duration."
		ifTrue: [ ^ duration > 0 ].
	
	aDeltaTime > duration
		ifTrue: [ ^ false ].

	aDistance := 0.0.
	
	state = Spline
		ifTrue: [ aDistance := self updateSpline: aDeltaTime ].
	state = Ballistic
		ifTrue: [ aDistance := self updateBallistic: aDeltaTime ].
	state = Cubic
		ifTrue: [ aDistance := self updateCubic: aDeltaTime ].
	
	currentPosition := startPosition + aDistance.
	^ true