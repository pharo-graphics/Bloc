updating
updateOn: aSplineOverScroller
	"Update the current position and velocity for current time.
	Returns true if update has been done and false if animation duration has been reached."
	<return: #Boolean>
	| aCurrentTime aDeltaTime aDistance|

	aCurrentTime := aSplineOverScroller time now.

	aDeltaTime := (aCurrentTime - aSplineOverScroller startTime).

	(aDeltaTime isZero)
		"Skip work but report that we're still going if we have a nonzero duration."
		ifTrue: [ ^ aSplineOverScroller duration isZero not ].

	aDeltaTime > aSplineOverScroller duration
		ifTrue: [ ^ false ].

	aDistance := 0.0.
	
	aSplineOverScroller currentStep = BlSplineOverScrollerStep spline
		ifTrue: [ aDistance := aSplineOverScroller updateSpline: aDeltaTime ].
	aSplineOverScroller currentStep = BlSplineOverScrollerStep ballistic
		ifTrue: [ aDistance := aSplineOverScroller updateBallistic: aDeltaTime ].
	aSplineOverScroller currentStep = BlSplineOverScrollerStep cubic
		ifTrue: [ aDistance := aSplineOverScroller updateCubic: aDeltaTime ].
	
	"Distance must be rounded and position converted to integer to prevent fractional locations"
	aSplineOverScroller currentPosition: (aSplineOverScroller startPosition + (aSplineOverScroller rounded: aDistance)).

	^ true